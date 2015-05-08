//
//  TTCounterComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 26/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTPropertyComponent.h"

/**
 Represents a steppable numerical property.
 */
@interface TTCounterComponent : TTPropertyComponent

/**
 Get or set the amount to increment or decrement by.
 */
@property (copy) NSNumber *step;

/**
 Increment the value.
 
 Note that if the @c value is currently anything other than a NSNumber, it will be converted.
 
 @returns YES if the @c value was incremented, otherwise NO.
 */
- (BOOL) increment;
/**
 Decrement the value. 
 
 Note that if the @c value is currently anything other than a NSNumber, it will be converted.
 
 @returns YES if the @c value was decremented, otherwise NO.
 */
- (BOOL) decrement;

@end
