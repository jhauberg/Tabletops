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
 Create a representation with a set of sides.
 */
+ (nonnull instancetype) representationWithSides: (nullable NSArray *) sides;

/**
 Get or set all the sides of the die.
 */
@property (nullable, strong) NSArray *sides;

/**
 Get or set the current upside of the die.
 */
@property (nullable, strong) id<NSObject, NSCopying, NSCoding> upside;

/**
 Designated initializer.
 
 Create a die representation with a given set of sides.
 
 @returns A TTDieRepresentation object with the given sides.
 */
- (nonnull instancetype) initWithSides: (nullable NSArray *) sides;

/**
 Roll the die.
 
 @returns The side facing up after rolling the die.
 */
- (nullable id) roll;

@end
