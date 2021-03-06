//
//  TTEntityGroupingComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"
#import "TTPropertyComponent.h"

@class TTEntity;

typedef BOOL (^TTEntityConditional)(TTEntity *__nonnull entity);

/**
 Base class for implementing entity groups.
 */
@interface TTEntityGroupingComponent<ObjectType : TTEntity *> : TTEntityComponent {
 @protected
    NSMutableArray<__kindof ObjectType> *_entities;
}

/**
 Create a new group.
 */
+ (nonnull instancetype) group;
/**
 Create a new group with a set of entities.
 */
+ (nonnull instancetype) groupWithEntities: (nonnull NSArray<__kindof ObjectType> *) entities;

/**
 Determine whether there's any entities in this group.
 */
@property (readonly) BOOL isEmpty;

/**
 Get the number of entities in this group.
 */
@property (readonly) NSUInteger count;
/**
 Get the number of entities in this group and in any child groupings.
 */
@property (readonly) NSUInteger countIncludingChildGroupings;

/**
 The entities contained in this group.
 */
@property (nonnull, readonly) NSArray<__kindof ObjectType> *entities;

/**
 Create a new group with a set of entities initially added.
 
 @returns a TTEntityGroupingComponent object with a set of entities already grouped.
 */
- (nonnull instancetype) initWithEntities: (nonnull NSArray<__kindof ObjectType> *) entities;

/**
 Add an entity to the group.
 
 @returns YES if the entity was added, otherwise NO.
 */
- (BOOL) addEntity: (nonnull ObjectType) entity;
/**
 Add multiple entities to the group.
 
 @returns YES if the entities were added, otherwise NO.
 */
- (BOOL) addEntities: (nonnull NSArray<__kindof ObjectType> *) entities;
/**
 Add multiple entities to the group, if specified, as an atomic operation.
 
 @returns YES if the entities were added, otherwise NO. If specified as an atomic operation,
          only returns YES if *all* the entities were added.
 */
- (BOOL) addEntities: (nonnull NSArray<__kindof ObjectType> *) entities
          atomically: (BOOL) atomically;

/**
 Remove an entity from the group.
 
 @returns YES if the entity was removed, otherwise NO.
 */
- (BOOL) removeEntity: (nonnull ObjectType) entity;
/**
 Remove multiple entities from the group.
 
 @returns YES if the entities were removed, otherwise NO.
 */
- (BOOL) removeEntities: (nonnull NSArray<__kindof ObjectType> *) entities;
/**
 Remove multiple entities from the group.
 
 @returns YES if the entities were removed, otherwise NO. If specified as an atomic operation,
          only returns YES if *all* the entities were removed.
 */
- (BOOL) removeEntities: (nonnull NSArray<__kindof ObjectType> *) entities
             atomically: (BOOL) atomically;
/**
 Remove all entities from the group.
 
 @returns YES if all the entities were removed, otherwise NO.
 */
- (BOOL) removeAllEntities;

/**
 Move an entity from another group to this group.
 
 @returns YES if the entity was moved, otherwise NO.
 */
- (BOOL) moveEntity: (nonnull ObjectType) entity fromGroup: (nonnull TTEntityGroupingComponent *) group;
/**
 Move an entity from another group to this group. If specified, as an atomic operation.
 
 @returns YES if the entity was moved, otherwise NO.
 */
- (BOOL) moveEntity: (nonnull ObjectType) entity
          fromGroup: (nonnull TTEntityGroupingComponent *) group
         atomically: (BOOL) atomically;
/**
 Move multiple entities from another group to this group.

 @returns YES if the entities were moved, otherwise NO.
 */
- (BOOL) moveEntities: (nonnull NSArray<__kindof ObjectType> *) entities
            fromGroup: (nonnull TTEntityGroupingComponent *) group;
/**
 Move multiple entities from another group to this group. If specified, as an atomic operation.

 @returns YES if the entities were moved, otherwise NO.
 */
- (BOOL) moveEntities: (nonnull NSArray<__kindof ObjectType> *) entities
            fromGroup: (nonnull TTEntityGroupingComponent *) group
           atomically: (BOOL) atomically;
/**
 Move all entities from another group to this group.

 @returns YES if the entities were moved, otherwise NO.
 */
- (BOOL) moveAllEntitiesFromGroup: (nonnull TTEntityGroupingComponent *) group;

/**
 Get the first entity that matches a condition.
 */
- (nonnull ObjectType) getEntityMatching: (nonnull TTEntityConditional) condition;
/**
 Get the first entity that matches a condition. If specified, also searches through child groups.
 */
- (nonnull ObjectType) getEntityMatching: (nonnull TTEntityConditional) condition
                        inChildGroupings: (BOOL) searchDeeper;
/**
 Get all entities that matches a condition.

 @returns An empty NSArray if @c condition is nil, or if no entities match the condition. Otherwise an NSArray containing all the matches.
 */
- (nonnull NSArray<__kindof ObjectType> *) getEntitiesMatching: (nonnull TTEntityConditional) condition;
/**
 Get all entities that matches a condition. If specified, also searches through child groups.

 @returns An empty NSArray if @c condition is nil, or if no entities match the condition. Otherwise an NSArray containing all the matches.
 */
- (nonnull NSArray<__kindof ObjectType> *) getEntitiesMatching: (nonnull TTEntityConditional) condition
                                              inChildGroupings: (BOOL) searchDeeper;

/**
 Sort entities by the default sorting behavior for the group.
 */
- (void) sort;
/**
 Sort entities by the provided comparison.
 */
- (void) sort: (nonnull NSComparator) comparison;
/**
 Sort entities by a specific property.
 */
- (void) sortBy: (nonnull TTPropertyComponent *) propertyComponent;
/**
 Sort entities by specific properties, in order. Must be property components.
 */
- (void) sortByComponents: (nonnull NSArray<__kindof TTPropertyComponent *> *) propertyComponents;

@end
