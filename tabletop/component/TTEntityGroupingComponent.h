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
 Base class for implementing entity groupings.
 */
@interface TTEntityGroupingComponent : TTEntityComponent {
 @protected
    NSMutableArray *_entities;
}

@property (readonly) NSArray *entities;

/**
 Add an entity to the grouping.
 
 @returns YES if the entity was added, otherwise NO.
 */
- (BOOL) addEntity: (TTEntity *) entity;
/**
 Add multiple entities to the grouping.
 
 @returns YES if the entities were added, otherwise NO.
 */
- (BOOL) addEntities: (NSArray *) entities;
/**
 Add multiple entities to the grouping, if specified, as an atomic operation.
 
 @returns YES if the entities were added, otherwise NO. If specified as an atomic operation, only returns YES if *all* the entities were added.
 */
- (BOOL) addEntities: (NSArray *) entities atomically: (BOOL) atomically;

/**
 Remove an entity from the grouping.
 
 @returns YES if the entity was removed, otherwise NO.
 */
- (BOOL) removeEntity: (TTEntity *) entity;
/**
 Remove multiple entities from the grouping.
 
 @returns YES if the entities were removed, otherwise NO.
 */
- (BOOL) removeEntities: (NSArray *) entities;
/**
 Remove multiple entities from the grouping.
 
 @returns YES if the entities were removed, otherwise NO. If specified as an atomic operation, only returns YES if *all* the entities were removed.
 */
- (BOOL) removeEntities: (NSArray *) entities atomically: (BOOL) atomically;
/**
 Remove all entities from the grouping.
 
 @returns YES if all the entities were removed, otherwise NO.
 */
- (BOOL) removeAllEntities;

/**
 Move an entity from a grouping to the receiver grouping.
 
 @returns YES if the entity was moved, otherwise NO.
 */
- (BOOL) moveEntity: (TTEntity *) entity fromGroup: (TTEntityGroupingComponent *) group;
/**
 Move an entity from a grouping to the receiver grouping, if specified, as an atomic operation.
 
 @returns YES if the entity was moved, otherwise NO.
 */
- (BOOL) moveEntity: (TTEntity *) entity fromGroup: (TTEntityGroupingComponent *) group atomically: (BOOL) atomically;
/**
 Move multiple entities from a grouping to the receiver grouping.

 @returns YES if the entities were moved, otherwise NO.
 */
- (BOOL) moveEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) group;
/**
 Move multiple entities from a grouping to the receiver grouping, if specified, as an atomic operation.

 @returns YES if the entities were moved, otherwise NO.
 */
- (BOOL) moveEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) group atomically: (BOOL) atomically;

/**
 Get all entities that matches a condition. This will search through child groupings too.

 @returns An empty NSArray if @c condition is nil, or if no entities match the condition, otherwise all the matches.
 */
- (NSArray *) getEntitiesMatching: (TTEntityConditional) condition;
/**
 Get all entities that matches a condition. If specified, also search through child groupings.
 
 @returns An empty NSArray if @c condition is nil, or if no entities match the condition, otherwise all the matches.
 */
- (NSArray *) getEntitiesMatching: (TTEntityConditional) condition inChildGroupings: (BOOL) searchDeeper;

/**
 Sort entities by the default sorting behavior for the grouping.
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
