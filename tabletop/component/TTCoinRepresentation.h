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

+ (instancetype) representationWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside andBackside: (id<NSCoding, NSObject, NSCopying>) backside;

/**
 Get or set the backside.
 */
@property (strong) id<NSCoding, NSObject, NSCopying> backside;

/**
 Get the currently visible side; either @c frontside or @c backside.
 */
@property (readonly) id<NSCoding, NSObject, NSCopying> visibleSide;

/**
 Determine whether the @c backside is currently showing.
 */
@property (readonly) BOOL isFlipped;

- (instancetype) initWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside andBackside: (id<NSCoding, NSObject, NSCopying>) backside;

/**
 Flip the coin, making it show its @c backside if it was showing its @c frontside before, or show its @c frontside if it was showing its @c backside before.
 */
- (void) flip;
/**
 Flip the coin, making it randomly show either its @c backside or @c frontside.
 */
- (void) flipRandomly;

/**
 Flip the coin to show its frontside.
 
 @returns YES if the coin was flipped, NO otherwise.
 */
- (BOOL) flipToFrontside;
/**
 Flip the coin to show its backside.
 
 @returns YES if the coin was flipped, NO otherwise.
 */
- (BOOL) flipToBackside;

@end
