//
//  TTCardRepresentation.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTCoinRepresentation.h"

/**
 Represents a card with both a frontside and a backside.
 */
@interface TTCardRepresentation : TTCoinRepresentation

+ (instancetype) representationWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside andBackside: (id<NSCoding, NSObject, NSCopying>) backside withFrontsideFacingUp: (BOOL) faceUp;

/**
 Determine whether the card is currently showing face up.
 */
@property (readonly) BOOL isFaceUp;
/**
 Determine whether the card is currently tapped.
 */
@property (readonly) BOOL isTapped;

- (instancetype) initWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside andBackside: (id<NSCoding, NSObject, NSCopying>) backside withFrontsideFacingUp: (BOOL) faceUp;

/**
 Flip the card, making it face up if it was facing down before, or face down if it was facing up before.
 */
- (void) flip;
/**
 Flip the card, making it randomly show either its @c backside or @c frontside.
 */
- (void) flipRandomly;

/**
 Flip the card to show its frontside.
 
 @returns YES if the card was flipped, NO otherwise.
 */
- (BOOL) flipToFrontside;
/**
 Flip the card to show its backside.
 
 @returns YES if the card was flipped, NO otherwise.
 */
- (BOOL) flipToBackside;

/**
 Tap the card, flagging it as being tapped unless it was already tapped, in which case it becomes un-tapped.
 */
- (void) tap;

@end
