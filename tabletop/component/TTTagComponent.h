//
//  TTTagComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

/**
 Provides a way of applying tags to an entity.
 */
@interface TTTagComponent : TTEntityComponent

/**
 Create a tag component.
 */
+ (nonnull instancetype) componentWithTag: (nullable NSString *) tag;

/**
 Get or set the tag.
 */
@property (nullable, strong) NSString *tag;

/**
 Designated initializer.

 Create a tag component.

 @returns A TTTagComponent object with a tag.
 */
- (nonnull instancetype) initWithTag: (nullable NSString *) tag;

/**
 Compare this tag to another tag.
 
 @returns The case-sensitive string comparison of this tag to the other tag.
 */
- (NSComparisonResult) compare: (nonnull TTTagComponent *) otherTag;

@end
