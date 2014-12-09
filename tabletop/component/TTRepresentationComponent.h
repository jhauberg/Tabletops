//
//  TTRepresentationComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

/**
 Base class for implementing physically representable components.
 */
@interface TTRepresentationComponent : TTEntityComponent

/**
 Get or set the location.
 */
@property (nonatomic, assign) CGPoint position;

/**
 Determine whether or not the position can be changed.
 */
@property (nonatomic, assign) BOOL isLocked;

@end
