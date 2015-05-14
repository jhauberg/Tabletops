//
//  TTCoinEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 14/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTCoinRepresentation.h"

/**
 Provides a common implementation of a coin entity.
 */
@interface TTCoinEntity : TTEntity

+ (instancetype) coinWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside andBackside: (id<NSCoding, NSObject, NSCopying>) backside;

/**
 Get the representation component. Can not be removed.

 Note that this component is only created and assigned when first used.
 */
@property (readonly) TTCoinRepresentation *representation;

@end
