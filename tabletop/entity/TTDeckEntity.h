//
//  TTDeckEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 19/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTDeckGroupingComponent.h"

/**
 Provides a common implementation of a deck entity.
 */
@interface TTDeckEntity : TTEntity

+ (instancetype) deck;

/**
 Get the grouping component for the contents of the deck. Can not be removed.
 
 Note that this component is only created and assigned when first used.
 */
@property (readonly) TTDeckGroupingComponent *group;

@end
