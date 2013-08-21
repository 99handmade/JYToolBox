//
//  CoreDataOperation.h
//  MFSC
//
//  Created by Jiehao YUAN on 06/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface CoreDataOperation : NSObject

@property (atomic, strong, readonly) NSPersistentStoreCoordinator *       persistentStoreCoordinator;

@property (atomic, strong, readonly) NSMutableDictionary *                classMappingDictionary;
@property (atomic, strong, readonly) NSMutableDictionary *                propertyMappingDictionary;
@property (atomic, strong, readonly) NSMutableDictionary *                relationshipMappingDictionary;

+ (CoreDataOperation *)sharedCoreDataOperation;

- (void)addClassRelationsWithManagedObjectClassName:(NSString *)managedObjectClassName
                             relatedObjectClassName:(NSString *)relatedObjectClassName;

- (void)addPropertyMappingDictionary:(NSDictionary *)propertyMappingDictionary relatedClassName:(NSString *)relatedClassName;

- (void)addRelationshipMappingDictionary:(NSDictionary *)relationshipMappingDictionary relatedClassName:(NSString *)relatedClassName;

- (void)setDbName:(NSString *)name;

- (void)fetchWithEntityName:(NSString *)entityName
            predicateFormat:(NSString *)predicateFormat
             sortDescriptor:(NSSortDescriptor *)sortDescriptor
 persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
                    success:(void (^)(NSArray * result))success
                    failure:(void (^)(NSError * error))failure
          finalInMainThread:(void (^)(void))final;

- (void)saveManagedObjectWithOperation:(void(^)(NSManagedObjectContext * managedObjContext, NSError * error))operation
            persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
                               success:(void(^)(void))success
                               failure:(void(^)(NSError * error))failure
                     finalInMainThread:(void(^)(void))final;

- (NSArray *)fetchSynchronousWithEntityName:(NSString *)entityName
                            predicateFormat:(NSString *)predicateFormat
                             sortDescriptor:(NSSortDescriptor *)sortDescriptor
                 persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end