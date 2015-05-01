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
 Draw an entity from the pile.

 @returns A randomly picked entity, if any, nil otherwise.
 */
- (TTEntity *) draw;

@end
