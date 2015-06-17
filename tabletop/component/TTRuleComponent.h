//
//  TTRuleComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 25/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

#import "TTRule.h"

/**
 Provides a way of attaching a rule to an entity.
 */
@interface TTRuleComponent : TTEntityComponent

@property (strong) TTRule *rule;

@end
