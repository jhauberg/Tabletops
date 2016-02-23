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
@interface TTOrderGroupingComponent<ObjectType : TTEntity *> : TTEntityGroupingComponent<ObjectType>

/**
 Get the current entity in the order.
 */
@property (nullable, readonly) ObjectType current;
/**
 Get the previous entity in the order.
 */
@property (nullable, readonly) ObjectType previous;
/**
 Get the next entity in the order.
 */
@property (nullable, readonly) ObjectType next;
/**
 Get the last entity in the order. The @c last entity is always the entity just before the @c first entity.
 */
@property (nullable, readonly) ObjectType last;
/**
 Get the first and starting entity in the order.
 */
@property (nullable, readonly) ObjectType first;

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
 Make the specified entity be the first in the order of entities. Note that this resets the current order.
 */
- (void) makeEntityFirstInOrder: (nonnull ObjectType) entity;

/**
 Make a random entity be the first in the order of entities. Note that this resets the current order.
 */
- (void) makeRandomEntityFirstInOrder;

@end
