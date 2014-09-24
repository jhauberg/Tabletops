//
//  TTDeckGroupingComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTEntityGroupingComponent.h"

@interface TTDeckGroupingComponent : TTEntityGroupingComponent <NSCoding, NSCopying>

@property (readonly) TTEntity *bottom;
@property (readonly) TTEntity *top;

- (void) shuffle;

// removes from deck
- (TTEntity *) drawCard: (TTEntity *) card;

- (TTEntity *) drawCardFromTop;
- (TTEntity *) drawCardFromBottom;
- (TTEntity *) drawCardAtRandom;
- (TTEntity *) drawCardAtIndex: (NSUInteger) index;

- (NSArray *) drawCardsFromTop: (NSUInteger) amount;
- (NSArray *) drawCardsFromBottom: (NSUInteger) amount;
- (NSArray *) drawCardsAtRandom: (NSUInteger) amount;

@end
