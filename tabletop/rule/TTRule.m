//
//  TTRule.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 07/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTRule.h"

@implementation TTRule

+ (instancetype) rule {
    return [[[self class] alloc] init];
}

+ (instancetype) ruleWithName: (NSString *) name {
    return [[[self class] alloc] initWithName: name];
}

+ (instancetype) ruleWithName: (NSString *) name
                 thatResolves: (TTRuleResolutionConditionBlock) condition {
    return [self ruleWithName: name
                 thatResolves: condition
            // default behavior for a rule is to always resolve successfully if condition is met
                           to: nil];
}

+ (instancetype) ruleWithName: (NSString *) name
               thatResolvesTo: (TTRuleResolutionBlock) resolution {
    return [self ruleWithName: name
            // default behavior for a rule is to always be resolvable if no condition is specified
                 thatResolves: nil
                           to: resolution];
}

+ (instancetype) ruleWithName: (NSString *) name
                 thatResolves: (TTRuleResolutionConditionBlock) condition
                           to: (TTRuleResolutionBlock) resolution {
    TTRule *rule = [self ruleWithName: name];

    if (rule) {
        rule.resolutionBlock = resolution;
        rule.resolutionConditionBlock = condition;
    }

    return rule;
}

+ (instancetype) ruleWithName: (NSString *) name
           thatResolvesBefore: (TTRuleResolutionConditionResponseBlock) responseCondition
                           to: (TTRuleResolutionResponseBlock) resolution {
    return [self ruleWithName: name
           thatResolvesBefore: responseCondition
                           to: resolution
                      orAfter: nil
                           to: nil];
}

+ (instancetype) ruleWithName: (NSString *) name
            thatResolvesAfter: (TTRuleResolutionConditionResponseBlock) responseCondition
                           to: (TTRuleResolutionResponseBlock) resolution {
    return [self ruleWithName: name
           thatResolvesBefore: nil
                           to: nil
                      orAfter: responseCondition
                           to: resolution];
}

+ (instancetype) ruleWithName: (NSString *) name
           thatResolvesBefore: (TTRuleResolutionConditionResponseBlock) responseConditionBefore
                           to: (TTRuleResolutionResponseBlock) resolutionBefore
                      orAfter: (TTRuleResolutionConditionResponseBlock) responseConditionAfter
                           to: (TTRuleResolutionResponseBlock) resolutionAfter {
    TTRule *rule = [self ruleWithName: name];

    if (rule) {
        rule.resolutionConditionBeforeBlock = responseConditionBefore;
        rule.resolutionBeforeBlock = resolutionBefore;
        rule.resolutionConditionAfterBlock = responseConditionAfter;
        rule.resolutionAfterBlock = resolutionAfter;
    }
    
    return rule;
}

- (instancetype) initWithName: (NSString *) name {
    if ((self = [super init])) {
        _name = name;
    }

    return self;
}

- (BOOL) canResolve: (id) state before: (TTRule *) rule {
    // override to implement behavior in subclass

    if (self.resolutionConditionBeforeBlock) {
        return self.resolutionConditionBeforeBlock(state, rule);
    }

    // by default, a rule can only be resolved before another rule if specified to
    return NO;
}

- (BOOL) canResolve: (id) state {
    // override to implement behavior in subclass

    if (self.resolutionConditionBlock) {
        return self.resolutionConditionBlock(state);
    }

    // by default, a rule can always be resolved unless otherwise specified by a condition block subclassed behavior
    return YES;
}

- (BOOL) canResolve: (id) state after: (TTRule *) rule {
    // override to implement behavior in subclass
    
    if (self.resolutionConditionAfterBlock) {
        return self.resolutionConditionAfterBlock(state, rule);
    }

    // by default, a rule can only be resolved after another rule if specified to
    return NO;
}

- (void) willResolveBefore: (TTRule *) rule {
    // override in subclass to implement behavior before a resolution attempt
}

- (void) willResolve {
    // override in subclass to implement behavior before a resolution attempt
}

- (void) willResolveAfter: (TTRule *) rule {
    // override in subclass to implement behavior before a resolution attempt
}

- (BOOL) resolve: (id) state before: (TTRule *) rule {
    // override to implement behavior in subclass

    if (![self resolve: state]) {
        return NO;
    }

    if (self.resolutionBeforeBlock) {
        return self.resolutionBeforeBlock(state, rule);
    }

    // by default, a rule always resolves successfully before another rule unless otherwise specified
    return YES;
}

- (BOOL) resolve: (id) state {
    // override to implement behavior in subclass

    if (self.resolutionBlock) {
        return self.resolutionBlock(state);
    }

    // by default, a rule always resolves successfully unless otherwise specified
    return YES;
}

- (BOOL) resolve: (id) state after: (TTRule *) rule {
    // override to implement behavior in subclass

    if (![self resolve: state]) {
        return NO;
    }

    if (self.resolutionAfterBlock) {
        return self.resolutionAfterBlock(state, rule);
    }

    // by default, a rule always resolves successfully after another rule unless otherwise specified
    return YES;
}

- (void) didResolve: (BOOL) successfully before: (TTRule *) rule {
    // override in subclass to implement behavior after a resolution attempt
}

- (void) didResolve: (BOOL) successfully {
    // override in subclass to implement behavior after a resolution attempt
}

- (void) didResolve: (BOOL) successfully after: (TTRule *) rule {
    // override in subclass to implement behavior after a resolution attempt
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"%@", self.name ? self.name : NSStringFromClass([self class])];
}

@end
