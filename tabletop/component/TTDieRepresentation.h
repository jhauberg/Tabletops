//
//  TTDieRepresentation.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTRepresentationComponent.h"

/**
 Represents a die with a certain amount of sides.
 */
@interface TTDieRepresentation : TTRepresentationComponent

/**
 Get all the sides of the die.
 */
@property (readonly) NSArray *sides;
/**
 Get the images for each side of the die.
 */
@property (strong) NSArray *sideImages;

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
 
 @returns The side facing up after landing the roll.
 */
- (id) roll;

@end
