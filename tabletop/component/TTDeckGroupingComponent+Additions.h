//
//  TTDeckGroupingComponent+Additions.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDeckGroupingComponent.h"

@interface TTDeckGroupingComponent (Additions)

/**
 Draw and remove cards from the bottom of the deck until a drawn card matches a condition.
 The card matching the condition is included in the drawn cards.
 
 @returns An NSArray of TTEntity objects.
 */
- (nonnull NSArray<__kindof TTEntity *> *) drawFromBottomUntil: (nonnull TTEntityConditional) condition;
/**
 Draw and remove cards from the bottom of the deck until a drawn card matches a condition.
 The card matching the condition is optionally included in the drawn cards.
 
 @returns An NSArray of TTEntity objects.
 */
- (nonnull NSArray<__kindof TTEntity *> *) drawFromBottomUntil: (nonnull TTEntityConditional) condition inclusive: (BOOL) inclusive;
/**
 Draw and remove cards from the top of the deck until a drawn card matches a condition.
 The card matching the condition is included in the drawn cards.
 
 @returns An NSArray of TTEntity objects.
 */
- (nonnull NSArray<__kindof TTEntity *> *) drawFromTopUntil: (nonnull TTEntityConditional) condition;
/**
 Draw and remove cards from the top of the deck until a drawn card matches a condition.
 The card matching the condition is optionally included in the drawn cards.
 
 @returns An NSArray of TTEntity objects.
 */
- (nonnull NSArray<__kindof TTEntity *> *) drawFromTopUntil: (nonnull TTEntityConditional) condition inclusive: (BOOL) inclusive;

@end
