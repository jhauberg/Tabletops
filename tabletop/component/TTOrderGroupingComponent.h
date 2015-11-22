//
//  TTOrderGroupingComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent.h"

/**
 Provides a mechanism for going through entities in a specific and repeating order;
 e.g. an order of players going clockwise around the table.
 */
@interface TTOrderGroupingComponent : TTEntityGroupingComponent

/**
 Get the current entity in the order.
 */
@property (nullable, readonly) TTEntity *current;
/**
 Get the previous entity in the order.
 */
@property (nullable, readonly) TTEntity *previous;
/**
 Get the next entity in the order.
 */
@property (nullable, readonly) TTEntity *next;
/**
 Get the last entity in the order. The @c last entity is always the entity just before the @c first entity.
 */
@property (nullable, readonly) TTEntity *last;
/**
 Get the first and starting entity in the order.
 */
@property (nullable, readonly) TTEntity *first;

/**
 Advance the order to the @c next entity.
 */
- (void) moveToNext;
/**
 Regress the order to the @c previous entity.
 */
- (void) moveToPrevious;

/**
 Reset the order. This makes the @c first entity in the order be the @c current entity.
 */
- (void) reset;

/**
 Make the specified entity be the first in the order of entities. This also resets the order.
 */
- (void) makeEntityFirstInOrder: (nonnull TTEntity *) entity;

@end
