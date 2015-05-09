//
//  TTRepresentationComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

/**
 Base class for implementing visually representable components.
 */
@interface TTRepresentationComponent : TTEntityComponent

/**
 Get or set the location.
 */
@property (assign, nonatomic) CGPoint position;

/**
 Determine whether or not the position can be changed.
 */
@property (assign) BOOL isLocked;

// todo: this should be represented by a rule instead; i.e. TTMayNotBeMovedRule...

@end
