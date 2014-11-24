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

@interface TTPlayerEntity : TTEntity

+ (TTPlayerEntity *) playerWithName: (NSString *) name;

@property (readonly) TTPropertyComponent *name;
@property (readonly) TTHandGroupingComponent *hand;

- (id) initWithName: (NSString *) name;

@end
