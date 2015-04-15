//
//  TTPlayerEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 24/11/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTPropertyComponent.h"
#import "TTHandGroupingComponent.h"

/**
 Provides a common implementation of a player entity.
 */
@interface TTPlayerEntity : TTEntity

+ (instancetype) playerWithName: (NSString *) name;

/**
 Get the name component. Can not be removed.
 */
@property (readonly) TTPropertyComponent *name;
/**
 Get the hand component. Can not be removed.
 */
@property (readonly) TTHandGroupingComponent *hand;

/**
 Designated initializer.
 
 Create a new player entity with a hand, and a name property.
 
 @returns A TTPlayerEntity object with a few components provided initially.
 */
- (instancetype) initWithName: (NSString *) name;

@end
