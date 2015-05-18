//
//  TTTagComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

/**
 Provides a way of adding additional tags to an entity.
 */
@interface TTTagComponent : TTEntityComponent

/**
 Create a tag component.
 */
+ (instancetype) componentWithTag: (NSString *) tag;

/**
 Get or set the tag.
 */
@property (strong) NSString *tag;

/**
 Designated initializer.

 Create a tag component.

 @returns A TTTagComponent object with a tag.
 */
- (instancetype) initWithTag: (NSString *) tag;

/**
 Compare this tag to another tag.
 
 @returns The case-sensitive string comparison of this tag to the other tag.
 */
- (NSComparisonResult) compare: (TTTagComponent *) otherTag;

@end
