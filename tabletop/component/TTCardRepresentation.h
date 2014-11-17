//
//  TTCardRepresentation.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTRepresentationComponent.h"

/**
 Represents a card with both a front and a back side.
 */
@interface TTCardRepresentation : TTRepresentationComponent <NSCoding, NSCopying>

@property (strong) NSString *frontImage;
@property (strong) NSString *backImage;

@property (readonly) id visibleImage;

@property (readonly) BOOL isFlipped;
@property (readonly) BOOL isTapped;

/**
 Flip the card, making it face up if it was facing down before, and vice versa.
 */
- (void) flip;
/**
 Tap the card, flagging it as being tapped unless it was already tapped, in which case it becomes un-tapped.
 */
- (void) tap;

@end
