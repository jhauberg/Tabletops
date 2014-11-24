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

@property (assign) CGPoint position;

@end
