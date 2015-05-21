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

typedef BOOL (^TTEntityConditional)(TTEntity *entity);

/**
 Base class for implementing entity groups.
 */
@interface TTEntityGroupingComponent : TTEntityComponent {
 @protected
    NSMutableArray *_entities;
}

/**
 Create a new group.
 */
+ (instancetype) group;
/**
 Create a new group with a set of entities.
 */
+ (instancetype) groupWithEntities: (NSArray *) entities;

/**
 Determine whether there's any entities in this group.
 */
@property (readonly) BOOL isEmpty;

/**
 Get the number of entities in this group.
 */
@property (readonly) NSUInteger count;

/**
 The entities within this group.
 */
@property (readonly) NSArray *entities;

/**
 Create a new group with a set of entities initially added.
 
 @returns a TTEntityGroupingComponent object with a set of entities already grouped.
 */
- (instancetype) initWithEntities: (NSArray *) entities;

/**
 Add an entity to the group.
 
 @returns YES if the entity was added, otherwise NO.
 */
- (BOOL) addEntity: (TTEntity *) entity;
/**
 Add multiple entities to the group.
 
 @returns YES if the entities were added, otherwise NO.
 */
- (BOOL) addEntities: (NSArray *) entities;
/**
 Add multiple entities to the group, if specified, as an atomic operation.
 
 @returns YES if the entities were added, otherwise NO. If specified as an atomic operation, only returns YES if *all* the entities were added.
 */
- (BOOL) addEntities: (NSArray *) entities atomically: (BOOL) atomically;

/**
 Remove an entity from the group.
 
 @returns YES if the entity was removed, otherwise NO.
 */
- (BOOL) removeEntity: (TTEntity *) entity;
/**
 Remove multiple entities from the group.
 
 @returns YES if the entities were removed, otherwise NO.
 */
- (BOOL) removeEntities: (NSArray *) entities;
/**
 Remove multiple entities from the group.
 
 @returns YES if the entities were removed, otherwise NO. If specified as an atomic operation, only returns YES if *all* the entities were removed.
 */
- (BOOL) removeEntities: (NSArray *) entities atomically: (BOOL) atomically;
/**
 Remove all entities from the group.
 
 @returns YES if all the entities were removed, otherwise NO.
 */
- (BOOL) removeAllEntities;

/**
 Move an entity from a group to the receiver group.
 
 @returns YES if the entity was moved, otherwise NO.
 */
- (BOOL) moveEntity: (TTEntity *) entity fromGroup: (TTEntityGroupingComponent *) group;
/**
 Move an entity from a group to the receiver group, if specified, as an atomic operation.
 
 @returns YES if the entity was moved, otherwise NO.
 */
- (BOOL) moveEntity: (TTEntity *) entity fromGroup: (TTEntityGroupingComponent *) group atomically: (BOOL) atomically;
/**
 Move multiple entities from a group to the receiver group.

 @returns YES if the entities were moved, otherwise NO.
 */
- (BOOL) moveEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) group;
/**
 Move multiple entities from a group to the receiver group, if specified, as an atomic operation.

 @returns YES if the entities were moved, otherwise NO.
 */
- (BOOL) moveEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) group atomically: (BOOL) atomically;
/**
 Move all entities from a group to the receiver group.

 @returns YES if the entities were moved, otherwise NO.
 */
- (BOOL) moveAllEntitiesFromGroup: (TTEntityGroupingComponent *) group;

/**
 Get all entities that matches a condition. This will search through child groups too (in case this group contains another group of entities).

 @returns An empty NSArray if @c condition is nil, or if no entities match the condition, otherwise all the matches.
 */
- (NSArray *) getEntitiesMatching: (TTEntityConditional) condition;
/**
 Get all entities that matches a condition. If specified, also searches through child groups.

 @returns An empty NSArray if @c condition is nil, or if no entities match the condition, otherwise all the matches.
 */
- (NSArray *) getEntitiesMatching: (TTEntityConditional) condition inChildGroupings: (BOOL) searchDeeper;

/**
 Sort entities by the default sorting behavior for the group.
 */
- (void) sort;
/**
 Sort entities by the provided comparison.
 */
- (void) sort: (NSComparator) comparison;
/**
 Sort entities by a specific property.
 */
- (void) sortBy: (TTPropertyComponent *) propertyComponent;
/**
 Sort entities by specific properties, in order. Must be property components.
 */
- (void) sortByComponents: (NSArray *) propertyComponents;

@end
