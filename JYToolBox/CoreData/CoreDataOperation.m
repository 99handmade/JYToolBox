//
//  CoreDataOperation.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 06/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "CoreDataOperation.h"

#import "Common.h"




@interface CoreDataOperation ()

@property (atomic) dispatch_group_t reading_dispatch_group;
@property (atomic) dispatch_group_t writing_dispatch_group;
@property (atomic) dispatch_queue_t writing_dispatch_queue;

- (id)relatedObjectWithManagedObject:(NSManagedObject *)managedObject;

@end

@implementation CoreDataOperation

@synthesize persistentStoreCoordinator              = _persistentStoreCoordinator;
@synthesize classMappingDictionary                  = _classMappingDictionary;
@synthesize propertyMappingDictionary               = _propertyMappingDictionary;
@synthesize relationshipMappingDictionary           = _relationshipMappingDictionary;

static CoreDataOperation *  _coreDataOperation = nil;
static NSString *           _dbName = nil;





#pragma mark - Class method

+ (CoreDataOperation *)sharedCoreDataOperation
{
  if (_coreDataOperation != nil) {
    return _coreDataOperation;
  }
  else {
    _coreDataOperation = [[CoreDataOperation alloc] init];
    return _coreDataOperation;
  }
}





#pragma mark - Init & Dealloc

- (id)init
{
  self = [super init];
  if (self) {
    self.reading_dispatch_group = dispatch_group_create();
    self.writing_dispatch_group = dispatch_group_create();
    self.writing_dispatch_queue = dispatch_queue_create([[NSString stringWithFormat:@"fr.%@.core_data_write_queue",
                                                          PROJECT_NAME] UTF8String], NULL);
    
    _classMappingDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    _propertyMappingDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    _relationshipMappingDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
  }
  return self;
}

- (void)dealloc
{
  // !!!if develop target change to iOS6, delete the release!!!
  dispatch_release(self.reading_dispatch_group);
  dispatch_release(self.writing_dispatch_group);
  dispatch_release(self.writing_dispatch_queue);
}







#pragma mark - Config Core Data operation

- (void)addClassRelationsWithManagedObjectClassName:(NSString *)managedObjectClassName
                             relatedObjectClassName:(NSString *)relatedObjectClassName
{
  [_classMappingDictionary setObject:relatedObjectClassName forKey:managedObjectClassName];
}

- (void)addPropertyMappingDictionary:(NSDictionary *)propertyMappingDictionary relatedClassName:(NSString *)relatedClassName
{
  [_propertyMappingDictionary setObject:propertyMappingDictionary forKey:relatedClassName];
}

- (void)addRelationshipMappingDictionary:(NSDictionary *)relationshipMappingDictionary relatedClassName:(NSString *)relatedClassName
{
  [_relationshipMappingDictionary setObject:relationshipMappingDictionary forKey:relatedClassName];
}





#pragma mark - Getter and Setter override

- (void)setDbName:(NSString *)name
{
  _dbName = name;
  
};

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
  if (_dbName == nil) {
    _dbName = PROJECT_NAME;
  }
  
  NSManagedObjectModel * managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
  
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  NSURL * storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]
                      URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", _dbName]];
  
  NSError * error = nil;
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
  
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    
  }
  return _persistentStoreCoordinator;
}



#pragma mark - Operations

- (id)relatedObjectWithManagedObject:(NSManagedObject *)managedObject
{
  //get the class name related the managed object class
  NSString * relatedClassName = [_classMappingDictionary objectForKey:managedObject.entity.name];
  if (relatedClassName != nil && relatedClassName.length > 0) {
    id relatedObject = [[NSClassFromString(relatedClassName) alloc] init];
    NSDictionary * propertyDic = [self.propertyMappingDictionary objectForKey:relatedClassName];
    for (NSString * coredataPropertyName in propertyDic.allKeys) {
      if ([managedObject valueForKey:coredataPropertyName] != nil) {
        [relatedObject setValue:[managedObject valueForKey:coredataPropertyName] forKey:[propertyDic valueForKey:coredataPropertyName]];
      }
    }
    
    NSDictionary * relationshipDic = [self.relationshipMappingDictionary objectForKey:relatedClassName];
    
    for (NSString * coredataRelationshipName in relationshipDic.allKeys) {
      NSMutableArray * relationshipArray = [NSMutableArray arrayWithCapacity:0];
      NSSet * objSet = [managedObject valueForKey:coredataRelationshipName];
      for (NSManagedObject * managedObj in objSet) {
        NSManagedObjectID * managedObjectID = managedObj.objectID;
        NSManagedObject * fullManagedObj = [managedObj.managedObjectContext existingObjectWithID:managedObjectID error:nil];
        id obj = [self relatedObjectWithManagedObject:fullManagedObj];
        [relationshipArray addObject:obj];
      }
      [relatedObject setValue:relationshipArray forKey:coredataRelationshipName];
    }
    return relatedObject;
  }
  
  return nil;
}

- (void)fetchWithEntityName:(NSString *)entityName
            predicateFormat:(NSString *)predicateFormat
             sortDescriptor:(NSSortDescriptor *)sortDescriptor
 persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
                    success:(void (^)(NSArray *))success
                    failure:(void (^)(NSError *))failure
          finalInMainThread:(void (^)(void))final

{
  //read first, a read thread has higher priority than a write thread
  dispatch_group_async(self.reading_dispatch_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    dispatch_group_wait(self.writing_dispatch_group, DISPATCH_TIME_FOREVER);
    
    NSManagedObjectContext * managedObjectContext = [[NSManagedObjectContext alloc]
                                                     initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    if (persistentStoreCoordinator == nil) {
      managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    else {
      managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
    }
    
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:entityName
                                                          inManagedObjectContext:managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    
    request.entity = entityDescription;
    request.resultType = NSManagedObjectIDResultType;
    
    if (predicateFormat != nil) {
      NSPredicate * predicate = [NSPredicate predicateWithFormat:predicateFormat];
      [request setPredicate:predicate];
    }
    
    if (sortDescriptor != nil) {
      [request setSortDescriptors:@[sortDescriptor]];
    }
    
    NSError * error;
    NSArray * fetchResultArray = [managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray * returnResultArray = [NSMutableArray arrayWithCapacity:0];
    
    if (fetchResultArray == nil) {
      failure([NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil]);
    }
    else {
      for (NSManagedObjectID * managedObjectID in fetchResultArray) {
        NSManagedObject * managedObject = [managedObjectContext existingObjectWithID:managedObjectID error:nil];
        id obj = [self relatedObjectWithManagedObject:managedObject];
        [returnResultArray addObject:obj];
      }
      success([NSArray arrayWithArray:returnResultArray]);
    }
    dispatch_sync(dispatch_get_main_queue(), final);
  });
}

- (void)saveManagedObjectWithOperation:(void(^)(NSManagedObjectContext * managedObjContext, NSError * error))operation
            persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
                               success:(void(^)(void))success
                               failure:(void(^)(NSError * error))failure
                     finalInMainThread:(void(^)(void))final
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
    dispatch_group_wait(self.reading_dispatch_group, DISPATCH_TIME_FOREVER);
    
    dispatch_group_async(self.writing_dispatch_group, self.writing_dispatch_queue, ^{
      
#warning TODO  if overtime
      
      NSManagedObjectContext * managedObjectContext = [[NSManagedObjectContext alloc]
                                                       initWithConcurrencyType:NSPrivateQueueConcurrencyType];
      
      if (persistentStoreCoordinator == nil) {
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
      }
      else {
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
      }

      managedObjectContext.undoManager = [[NSUndoManager alloc] init];
      
      NSError * error = nil;
      operation(managedObjectContext, error);
      if (error != nil) {
        failure([NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil]);
      }
      else {
        success();
      }
      dispatch_sync(dispatch_get_main_queue(), final);
    });
  });
}

- (NSArray *)fetchSynchronousWithEntityName:(NSString *)entityName
                            predicateFormat:(NSString *)predicateFormat
                             sortDescriptor:(NSSortDescriptor *)sortDescriptor
                 persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
  NSManagedObjectContext * managedObjectContext = [[NSManagedObjectContext alloc]
                                                   initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  
  if (persistentStoreCoordinator == nil) {
    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
  }
  else {
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
  }
  
  NSEntityDescription * entityDescription = [NSEntityDescription entityForName:entityName
                                                        inManagedObjectContext:managedObjectContext];
  NSFetchRequest * request = [[NSFetchRequest alloc] init];
  request.resultType = NSManagedObjectIDResultType;
  [request setEntity:entityDescription];
  
  
  if (predicateFormat != nil) {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:predicateFormat];
    [request setPredicate:predicate];
  }
  
  if (sortDescriptor != nil) {
    [request setSortDescriptors:@[sortDescriptor]];
  }

  NSError * error;
  NSArray * fetchResultArray = [managedObjectContext executeFetchRequest:request error:&error];
  NSMutableArray * returnResultArray = [NSMutableArray arrayWithCapacity:0];
  
  if (fetchResultArray != nil) {
    for (NSManagedObjectID * managedObjectID in fetchResultArray) {
      NSManagedObject * managedObject = [managedObjectContext existingObjectWithID:managedObjectID error:nil];
      id obj = [self relatedObjectWithManagedObject:managedObject];
      [returnResultArray addObject:obj];
    }
    return returnResultArray;
  }
  
  return nil;
}

@end