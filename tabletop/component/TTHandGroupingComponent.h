//
//  TTHandGroupingComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 22/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent.h"

/**
 Provides a player with ownership of entities.
 */
@interface TTHandGroupingComponent : TTEntityGroupingComponent

/**
 The player who has ownership of the entities in this group.
 */
@property (strong) TTEntity *owner;

/**
 Designated initializer.
 
 Create a hand for a player. A "hand" is a grouping of the entities that the player currently has ownership of, 
 but is still part of the game as a whole; i.e. dice, tokens and cards (potentially a deck of cards that are only visible to the player).
 
 @returns A TTHandGroupingComponent object with a given owner.
 */
- (id) initWithOwner: (TTEntity *) owner;

@end
