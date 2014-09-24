//
//  TTRepresentationComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTEntityComponent.h"

@interface TTRepresentationComponent : TTEntityComponent <NSCoding, NSCopying>

// probably needs to be tied to an SKSprite, and doesn't need to keep a position property (sprite does this)

@property (assign) CGPoint position;

@end
