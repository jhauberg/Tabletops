//
//  TTPropertyComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

/**
 Represents a named property of any value.
 */
@interface TTPropertyComponent : TTEntityComponent

/**
 Create a property component with a named property and an initial value.
 */
+ (nonnull instancetype) propertyWithName: (nullable NSString *) name
                                 andValue: (nullable id<NSCoding, NSObject, NSCopying>) value;

/**
 Get or set the name of the property.
 */
@property (nullable, strong) NSString *name;

/**
 Get or set the value of the property.
 */
@property (nullable, strong) id<NSCoding, NSObject, NSCopying> value;

/**
 Get the current @c value as an NSNumber object.
 
 @returns The current @c value as an NSNumber object if possible, nil otherwise.
 */
@property (nullable, readonly) NSNumber *numberValue;
/**
 Get the current @c value as an NSString object.

 @returns The current @c value as a NSString object if possible, nil otherwise.
 */
@property (nullable, readonly) NSString *stringValue;

/**
 Designated initializer.
 
 Create a property component with a named property and an initial value.
 
 @returns A TTPropertyComponent object with a named property/value.
 */
- (nonnull instancetype) initWithName: (nullable NSString *) name
                             andValue: (nullable id<NSCoding, NSObject, NSCopying>) value;

/**
 Compare the receiver to another property component.
 
 @returns NSOrderedSame if the other property is considered equal to the receiver, 
          NSOrderedAscending if the other property is considered greater than the receiver and
          NSOrderedDescending if the other property is considered less.
 */
- (NSComparisonResult) compare: (nonnull TTPropertyComponent *) otherProperty;

@end
