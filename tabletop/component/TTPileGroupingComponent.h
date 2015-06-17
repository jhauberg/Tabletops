//
//  TTPileGroupingComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 01/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent.h"

/**
 Groups entities as tokens in a pile or bag.
 
 A pile can be drawn from (similar to a deck), but always randomly.
 */
@interface TTPileGroupingComponent : TTEntityGroupingComponent

/**
 Draw an entity and remove it from the pile.

 @returns A randomly picked entity, if any. Nil otherwise.
 */
- (nullable TTEntity *) draw;

/**
 Draw several entities and remove them from the pile.

 @returns An NSArray of up to @c amount of randomly picked entities, if any. An empty array otherwise.
 */
- (nonnull NSArray *) draw: (NSUInteger) amount;

@end
