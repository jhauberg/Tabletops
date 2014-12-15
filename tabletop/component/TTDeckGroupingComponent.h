//
//  TTDeckGroupingComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent.h"

/**
 Groups entities as cards in a deck.
 */
@interface TTDeckGroupingComponent : TTEntityGroupingComponent

/**
 The bottom card of the deck.
 */
@property (readonly) TTEntity *bottom;
/**
 The top card of the deck.
 */
@property (readonly) TTEntity *top;

/**
 Flip cards to be face-down when they are added to the deck.
 */
@property (assign) BOOL addsFaceDown;
/**
 Flip cards to be face-up when they are drawn from the deck.
 */
@property (assign) BOOL drawsFaceUp;

/**
 Shuffle the order that the cards occur in.
 */
- (void) shuffle;

/**
 Draw a card at a given position and remove it from the deck.

 @returns The TTEntity object located at index.
 */
- (TTEntity *) drawAtIndex: (NSUInteger) index;

/**
 Draw the card and remove it from the deck.
 
 @returns The card specified if it is in the deck, nil otherwise.
 */
- (TTEntity *) draw: (TTEntity *) card;

/**
 Draw a card from the top and remove it from the deck.
 
 @returns The TTEntity object located at the last index.
 */
- (TTEntity *) drawFromTop;
/**
 Draw a card from the bottom and remove it from the deck.
 
 @returns The TTEntity object located at the first index.
 */
- (TTEntity *) drawFromBottom;
/**
 Draw a card at a random position and remove it from the deck.
 
 @returns The TTEntity object located at a random index.
 */
- (TTEntity *) drawAtRandom;

/**
 Draw an amount of cards (or as many possible) from the top and remove them from the deck.
 
 @returns An NSArray of TTEntity objects located at the last indexes.
 */
- (NSArray *) drawFromTop: (NSUInteger) amount;
/**
 Draw an amount of cards (or as many possible) from the bottom and remove them from the deck.
 
 @returns An NSArray of TTEntity objects located at the first indexes.
 */
- (NSArray *) drawFromBottom: (NSUInteger) amount;
/**
 Draw an amount of cards (or as many possible) from random positions and remove them from the deck.
 
 @returns An NSArray of TTEntity objects located at random indexes.
 */
- (NSArray *) drawAtRandom: (NSUInteger) amount;

@end
