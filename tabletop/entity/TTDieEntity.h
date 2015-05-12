//
//  TTDieEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 11/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTDieRepresentation.h"

/**
 Provides a common implementation of a die entity.
 */
@interface TTDieEntity : TTEntity

+ (instancetype) dieWithSides: (NSArray *) sides;

/**
 Get the representation component. Can not be removed.
 
 Note that this component is only created and assigned when first used.
 */
@property (readonly) TTDieRepresentation *representation;

@end
