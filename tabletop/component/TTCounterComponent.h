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
@property (nonatomic, strong) NSNumber *step;

/**
 Increment the value.
 
 @returns YES if the value was incremented, otherwise NO.
 */
- (BOOL) increment;
/**
 Decrement the value.
 
 @returns YES if the value was decremented, otherwise NO.
 */
- (BOOL) decrement;

@end
