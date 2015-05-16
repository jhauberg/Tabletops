//
//  TTPlayerEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 24/11/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTHandGroupingComponent.h"

/**
 Provides a common implementation of a player entity.
 */
@interface TTPlayerEntity : TTEntity

/**
 Get the hand component. Can not be removed.
 
 Note that this component is only created and assigned when first used.
 */
@property (readonly) TTHandGroupingComponent *hand;

@end
