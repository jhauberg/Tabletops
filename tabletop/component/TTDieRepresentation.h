//
//  TTDieRepresentation.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTRepresentationComponent.h"

/**
 Represents a die with a set amount of sides.
 */
@interface TTDieRepresentation : TTRepresentationComponent

/**
 Get or set all the sides of the die.
 */
@property (strong) NSArray *sides;

/**
 Get or set the current upside of the die.
 */
@property (strong) id<NSObject, NSCopying, NSCoding> upside;

/**
 Designated initializer.
 
 Create a die representation with a given set of sides.
 
 @returns A TTDieRepresentation object with the given sides.
 */
- (instancetype) initWithSides: (NSArray *) sides;

/**
 Roll the die.
 
 @returns The side facing up after rolling the die.
 */
- (id) roll;

@end
