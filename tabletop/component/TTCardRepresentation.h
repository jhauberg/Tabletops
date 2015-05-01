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
@interface TTCardRepresentation : TTRepresentationComponent

/**
 Get or set the face-up image of the card.
 */
@property (strong) NSString *frontImage;
/**
 Get or set the face-down image of the card.
 */
@property (strong) NSString *backImage;

/**
 Get the currently visible side image; either @c frontImage or @c backImage.
 */
@property (readonly) NSString *visibleImage;

/**
 Determine whether the card is currently showing face-up.
 */
@property (readonly) BOOL isFaceUp;
/**
 Determine whether the card is currently tapped.
 */
@property (readonly) BOOL isTapped;

/**
 Flip the card, making it face up if it was facing down before, or face down if it was facing up before.
 */
- (void) flip;
/**
 Tap the card, flagging it as being tapped unless it was already tapped, in which case it becomes un-tapped.
 */
- (void) tap;

@end
