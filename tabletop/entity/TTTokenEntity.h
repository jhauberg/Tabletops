//
//  TTTokenEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 12/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTTokenRepresentation.h"

/**
 Provides a common implementation of a token entity.
 */
@interface TTTokenEntity : TTEntity

+ (instancetype) tokenWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside;

/**
 Get the representation component. Can not be removed.

 Note that this component is only created and assigned when first used.
 */
@property (readonly) TTTokenRepresentation *representation;

@end
