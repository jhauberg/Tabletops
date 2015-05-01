//
//  TTCoinRepresentation.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 01/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTokenRepresentation.h"

/**
 Represents a flippable token.
 */
@interface TTCoinRepresentation : TTTokenRepresentation

/**
 Get or set the backside image of the card.
 */
@property (strong) NSString *backImage;

/**
 Get the currently visible side image; either @c frontImage or @c backImage.
 */
@property (readonly) NSString *visibleImage;

/**
 Determine whether the coin is currently showing its backside.
 */
@property (readonly) BOOL isFlipped;

/**
 Flip the coin, making it show its backside if it was showing its frontside before, or show its frontside if it was showing its backside before.
 */
- (void) flip;
/**
 Flip the coin, making it randomly show either its back- or frontside.
 */
- (void) flip: (BOOL) randomly;

@end
