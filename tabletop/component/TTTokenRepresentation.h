//
//  TTTokenRepresentation.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTRepresentationComponent.h"

/**
 Represents a token with a single side.
 */
@interface TTTokenRepresentation : TTRepresentationComponent

/**
 Create a representation with a frontside.
 */
+ (nonnull instancetype) representationWithFrontside: (nullable id<NSCoding, NSObject, NSCopying>) frontside;

/**
 Get or set the frontside.
 */
@property (nullable, strong) id<NSCoding, NSObject, NSCopying> frontside;

- (nonnull instancetype) initWithFrontside: (nullable id<NSCoding, NSObject, NSCopying>) frontside;

@end
