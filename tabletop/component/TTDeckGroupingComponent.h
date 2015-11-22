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
 
 A deck can be sorted, shuffled and drawn from (either randomly or specifically).
 */
@interface TTDeckGroupingComponent<ObjectType : TTEntity *> : TTEntityGroupingComponent<ObjectType>

/**
 The bottom card of the deck.
 */
@property (nullable, readonly) ObjectType bottom;
/**
 The top card of the deck.
 */
@property (nullable, readonly) ObjectType top;

/**
 Flip cards to be face-down when they are added to the deck.
 
 This property only affects entities which have a TTCardRepresentation component assigned.
 */
@property (assign) BOOL addsFaceDown;
/**
 Flip cards to be face-up when they are drawn from the deck.
 
 This property only affects entities which have a TTCardRepresentation component assigned.
 */
@property (assign) BOOL drawsFaceUp;

/**
 Shuffle the order that the cards occur in.
 */
- (void) shuffle;

/**
 Draw a card and remove it from the deck.
 
 @returns The card specified if it is in the deck, nil otherwise.
 */
- (nullable ObjectType) draw: (nonnull ObjectType) card;
/**
 Draw a card at a given position and remove it from the deck.

 @returns The TTEntity object located at index, or nil if out of bounds.
 */
- (nullable ObjectType) drawAtIndex: (NSUInteger) index;

/**
 Draw a card from the top and remove it from the deck.
 
 @returns The TTEntity object located at the last index, or nil if the deck is empty.
 */
- (nullable ObjectType) drawFromTop;
/**
 Draw a card from the bottom and remove it from the deck.
 
 @returns The TTEntity object located at the first index, or nil if the deck is empty.
 */
- (nullable ObjectType) drawFromBottom;
/**
 Draw a card at a random position and remove it from the deck.
 
 @returns The TTEntity object located at a random index, or nil if the deck is empty.
 */
- (nullable ObjectType) drawAny;

/**
 Draw an amount of cards (or as many possible) from the top and remove them from the deck.
 
 @returns An NSArray of TTEntity objects located at the last indexes.
 */
- (nonnull NSArray<__kindof ObjectType> *) drawFromTop: (NSUInteger) amount;
/**
 Draw and remove cards from the top of the deck until a drawn card matches a condition.
 
 The card matching the condition is included in the drawn cards.
 
 @returns An NSArray of TTEntity objects.
 */
- (nonnull NSArray<__kindof ObjectType> *) drawFromTopUntil: (nonnull TTEntityConditional) condition;
/**
 Draw and remove cards from the top of the deck until a drawn card matches a condition.

 The card matching the condition is optionally included in the drawn cards.
 
 @returns An NSArray of TTEntity objects.
 */
- (nonnull NSArray<__kindof ObjectType> *) drawFromTopUntil: (nonnull TTEntityConditional) condition
                                                  inclusive: (BOOL) inclusive;
/**
 Draw an amount of cards (or as many possible) from the bottom and remove them from the deck.
 
 @returns An NSArray of TTEntity objects located at the first indexes.
 */
- (nonnull NSArray<__kindof ObjectType> *) drawFromBottom: (NSUInteger) amount;
/**
 Draw and remove cards from the bottom of the deck until a drawn card matches a condition.

 The card matching the condition is included in the drawn cards.
 
 @returns An NSArray of TTEntity objects.
 */
- (nonnull NSArray<__kindof ObjectType> *) drawFromBottomUntil: (nonnull TTEntityConditional) condition;
/**
 Draw and remove cards from the bottom of the deck until a drawn card matches a condition.

 The card matching the condition is optionally included in the drawn cards.
 
 @returns An NSArray of TTEntity objects.
 */
- (nonnull NSArray<__kindof ObjectType> *) drawFromBottomUntil: (nonnull TTEntityConditional) condition
                                                     inclusive: (BOOL) inclusive;
/**
 Draw an amount of cards (or as many possible) from random positions and remove them from the deck.
 
 @returns An NSArray of TTEntity objects located at random indexes.
 */
- (nonnull NSArray<__kindof ObjectType> *) drawAny: (NSUInteger) amount;

/**
 Send a card to the bottom of the deck.
 
 @return YES if the card was moved, or was already at the bottom, NO otherwise.
 */
- (BOOL) sendToBottom: (nonnull ObjectType) card;
/**
 Bring a card to the top of the deck.
 
 @return YES if the card was moved, or was already at the top, NO otherwise.
 */
- (BOOL) bringToTop: (nonnull ObjectType) card;

@end
