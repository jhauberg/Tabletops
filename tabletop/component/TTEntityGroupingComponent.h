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

/**
 Base class for implementing entity groupings.
 */
@interface TTEntityGroupingComponent : TTEntityComponent <NSCoding, NSCopying> {
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
 Remove an entity from the grouping.
 
 @returns YES if the entity was removed, otherwise NO.
 */
- (BOOL) removeEntity: (TTEntity *) entity;

/**
 Move an entity from a grouping to the receiver grouping.
 
 @returns YES if the entity was moved, otherwise NO.
 */
- (BOOL) moveEntity: (TTEntity *) entity fromGrouping: (TTEntityGroupingComponent *) grouping;
- (BOOL) moveEntity: (TTEntity *) entity fromGrouping: (TTEntityGroupingComponent *) grouping atomically: (BOOL) atomically;

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
 Sort entities by specific properties, in order.
 */
- (void) sortByComponents: (NSArray *) propertyComponents;

@end
