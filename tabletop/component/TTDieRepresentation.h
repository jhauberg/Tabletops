//
//  TTDieRepresentation.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTRepresentationComponent.h"

@interface TTDieRepresentation : TTRepresentationComponent <NSCoding, NSCopying>

@property (readonly) NSArray *sides;
@property (readonly) id<NSObject, NSCopying, NSCoding> upside;

@property (strong) NSArray *sideImages;

- (id) initWithSides: (NSArray *) sides;

- (id) roll;

@end
