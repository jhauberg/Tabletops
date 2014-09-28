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

@property (assign) BOOL addsFaceDown;
@property (assign) BOOL drawsFaceUp;

- (void) shuffle;

- (TTEntity *) drawAtIndex: (NSUInteger) index;

- (TTEntity *) draw: (TTEntity *) card;

- (TTEntity *) drawFromTop;
- (TTEntity *) drawFromBottom;
- (TTEntity *) drawAtRandom;

- (NSArray *) drawFromTop: (NSUInteger) amount;
- (NSArray *) drawFromBottom: (NSUInteger) amount;
- (NSArray *) drawAtRandom: (NSUInteger) amount;

@end
