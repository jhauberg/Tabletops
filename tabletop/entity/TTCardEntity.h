//
//  TTCardEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 16/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTCardRepresentation.h"

/**
 Provides a common implementation of a card entity.
 */
@interface TTCardEntity : TTEntity

+ (instancetype) card;

/**
 Get the representation component. Can not be removed.
 
 Note that this component is only created and assigned when first used.
 */
@property (readonly) TTCardRepresentation *representation;

@end
