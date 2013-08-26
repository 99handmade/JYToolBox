JYToolBox
=========

a tool library [iOS]

////////////////////////////////////////////////////////////////////////separator////////////////////////////////////////////////////////////////////////

Common.h  - define macro, common variable, font, color...

CoreDataOperation - a class to use CoreData in multi-thread and to not block the main thread      [undone]

/////////Tutorial for [CoreDataOperation]/////////

To fetch managed object from Core Data data base, create a related class for the core data managed class, for example :

<pre>
<code>
@interface ManagedObjectClass : NSManagedObject

@property (nonatomic, retain) NSNumber * aNumber;
@property (nonatomic, retain) NSObject * aObject;
@property (nonatomic, retain) NSSet *    aSet;     //who contains CoreDataElement object

@end
</code>
</pre>

<pre>
<code>
@interface RelatedObjectClass : NSObject

@property (nonatomic, assign) NSInteger   aInteger;
@property (nonatomic, strong) NSObject *  aRelatedObject;
@property (nonatomic, strong) NSArray *   aSet;    //must be the same name to managed object class

@end
</code>
</pre>

<pre>
<code>
[[CoreDataOperation sharedCoreDataOperation] addClassRelationsWithManagedObjectClassName:@"ManagedObjectClass"
                                                                 relatedObjectClassName:@"RelatedObjectClass"];
                                                                 
[[CoreDataOperation sharedCoreDataOperation] addPropertyMappingDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                           @"aInteger", @"aNumber",
                                                                           @"aRelatedObject", @"aObject", nil]
                                                         relatedClassName:@"RelatedObjectClass"];
                                                         
[[CoreDataOperation sharedCoreDataOperation] addRelationshipMappingDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                               @"CoreDataEement", @"aSet", nil]
                                                            relatedClassName:@"RelatedObjectClass"];
</code>
</pre>
