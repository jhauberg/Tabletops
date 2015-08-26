//
//  TTRuleStack.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 09/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "Tabletops.h"

#import "TTRuleStack.h"

@implementation TTRuleStack {
 @private
    NSMutableArray *_rules;
    
    BOOL _requiresResolution;
}

- (instancetype) init {
    if ((self = [super init])) {
        if (!_rules) {
            _rules = [[NSMutableArray alloc] init];
        }
    }

    return self;
}

- (BOOL) isEmpty {
    return _rules == nil || [_rules count] == 0;
}

- (NSUInteger) count {
    return _rules != nil ? [_rules count] : 0;
}

- (NSArray *) rules {
    if (_rules) {
        NSMutableArray *reversedRules = [NSMutableArray arrayWithCapacity:
                                         [_rules count]];

        NSEnumerator *reverseEnumerator = [_rules reverseObjectEnumerator];

        for (id rule in reverseEnumerator) {
            [reversedRules addObject: rule];
        }

        return [NSArray arrayWithArray: reversedRules];
    }

    return [NSArray array];
}

- (void) removeAllRules {
    [_rules removeAllObjects];
}

- (void) removeAllRulesExcept: (TTRule *) rule {
    [self removeAllRules];

    [_rules addObject: rule];
}

- (void) removeAllRulesExceptRules: (NSArray *) rules {
    [self removeAllRules];

    [_rules addObjectsFromArray: rules];
}

- (BOOL) removeRule: (TTRule *) rule {
    if (!rule) {
        return NO;
    }
    
    if (![_rules containsObject: rule]) {
        TTDebugWarning(@"Rule '%@' is not in the rule stack. It was not removed.", rule);

        return NO;
    }

    [_rules removeObject: rule];

    return YES;
}

- (BOOL) push: (TTRule *) rule {
    if (!rule) {
        return NO;
    }
    
    if ([_rules containsObject: rule]) {
        TTDebugWarning(@"Rule '%@' is already in the rule stack. It was not added.", rule);
        
        return NO;
    }

    [_rules addObject: rule];

    // a new rule may be pushed during the resolution of another rule, so this is set
    // in order to trigger another resolution pass at the end of the current pass (if any)
    _requiresResolution = YES;

    return YES;
}

- (TTRuleResolutionConditionResponseBlock) conditionForRule: (TTRule *) rule thatRespondsToRule: (TTRule *) triggerRule {
    TTRuleResolutionConditionBlock existingCondition = rule.resolutionConditionBlock;

    // rules default to be resolvable, so to prevent the rule from resolving out of order when meant to trigger
    // in response to another rule being resolved/having been resolved, add a block that says it cannot be resolved
    // if it doesn't happen as a before/after response
    rule.resolutionConditionBlock = ^BOOL(id state) {
        return NO;
    };

    return ^BOOL(id state, TTRule *anotherRule) {
        BOOL shouldTriggerInResponseToRule =
            anotherRule == triggerRule ||
            [anotherRule isEqual: triggerRule] ||
            [anotherRule.name isEqualToString: triggerRule.name];

        if (shouldTriggerInResponseToRule) {
            if (existingCondition) {
                return existingCondition(state);
            }

            return YES;
        }

        return NO;
    };
}

- (BOOL) push: (TTRule *) rule before: (TTRule *) otherRule {
    if ([self push: rule]) {
        rule.resolutionConditionBeforeBlock = [self conditionForRule: rule
                                                  thatRespondsToRule: otherRule];

        return YES;
    }
    
    return NO;
}

- (BOOL) push: (TTRule *) rule beforeRuleNamed: (NSString *) otherRuleName {
    return [self push: rule
               before: [TTRule ruleWithName:
                        otherRuleName]];
}

- (BOOL) push: (TTRule *) rule after: (TTRule *) otherRule {
    if ([self push: rule]) {
        rule.resolutionConditionAfterBlock = [self conditionForRule: rule
                                                 thatRespondsToRule: otherRule];

        return YES;
    }
    
    return NO;
}

- (BOOL) push: (TTRule *) rule afterRuleNamed: (NSString *) otherRuleName {
    return [self push: rule
                after: [TTRule ruleWithName:
                        otherRuleName]];
}

- (BOOL) pushRules: (NSArray *) rules {
    for (TTRule *rule in rules) {
        if (![self push: rule]) {
            return NO;
        }
    }

    return YES;
}

- (BOOL) pushRuleSequence: (NSArray *) ruleSequence {
    if (ruleSequence == nil || [ruleSequence count] == 0) {
        return NO;
    }
    
    for (TTRule *rule in [ruleSequence reverseObjectEnumerator]) {
        if (![self push: rule]) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) pushRuleSequence: (NSArray *) ruleSequence before: (TTRule *) otherRule {
    if (ruleSequence == nil || [ruleSequence count] == 0) {
        return NO;
    }
    
    for (TTRule *rule in [ruleSequence reverseObjectEnumerator]) {
        if (![self push: rule before: otherRule]) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) pushRuleSequence: (NSArray *) ruleSequence after: (TTRule *) otherRule {
    if (ruleSequence == nil || [ruleSequence count] == 0) {
        return NO;
    }
    
    for (TTRule *rule in [ruleSequence reverseObjectEnumerator]) {
        if (![self push: rule after: otherRule]) {
            return NO;
        }
    }
    
    return YES;
}

- (void) resolveWithState: (id) state before: (TTRule *) rule {
    if (self.isEmpty) {
        return;
    }

    NSArray *rules = [NSArray arrayWithArray: _rules];

    for (TTRule *otherRule in [rules reverseObjectEnumerator]) {
        if (otherRule == rule) {
            continue;
        }
        
        if ([otherRule canResolve: state before: rule]) {
            if (!self.isEmpty) {
                // recurse until we have resolved all rules that trigger off this and each other down the chain, then finally resolve this rule
                [self resolveWithState: state
                                before: otherRule];
            }

            TTDebug(@"  trying to resolve: %@ ← %@...", otherRule, rule);

            [otherRule willResolveBefore: rule];
            
            if ([otherRule resolve: state before: rule]) {
                TTDebug(@"    resolved ✓");

                [otherRule didResolve: YES
                               before: rule];
                
                if (!otherRule.persistsWhenResolved) {
                    [self removeRule: otherRule];

                    TTDebug(@"      and removed");
                }
                
                if (!self.isEmpty) {
                    // then resolve any rules that trigger after this rule
                    [self resolveWithState: state
                                     after: otherRule];
                }
            } else {
                TTDebug(@"    not resolved ✗");

                [otherRule didResolve: NO
                               before: rule];
                
                if (otherRule.removedIfNotResolved) {
                    [self removeRule: otherRule];

                     TTDebug(@"      but removed");
                }
            }
        }
        
        if (self.isEmpty) {
            break;
        }
    }
}

- (void) resolveWithState: (id) state {
    if (self.isEmpty) {
        TTDebug(@"no rules to process");

        return;
    }
    
    _requiresResolution = NO;

    TTDebug(@"processing rules...");

    NSArray *rules = [NSArray arrayWithArray: _rules];

    // go through all processable rules, from top to bottom; first in, last out.
    for (TTRule *rule in [rules reverseObjectEnumerator]) {
        TTDebug(@"processing: %@", rule);

        // determine if the rule can resolve with the current game state
        if ([rule canResolve: state]) {
            if (!self.isEmpty) {
                // before resolving the rule, determine if any other rules should resolve in response to this rule resolving
                [self resolveWithState: state
                                before: rule];
            }

            TTDebug(@"  trying to resolve: %@...", rule);

            [rule willResolve];
            
            // then finally resolve the rule
            if ([rule resolve: state]) {
                TTDebug(@"    resolved ✓");

                [rule didResolve: YES];
                
                if (!rule.persistsWhenResolved) {
                    [self removeRule: rule];

                    TTDebug(@"      and removed");
                }
                
                if (!self.isEmpty) {
                    // after resolving the rule, determine if any other rules should resolve in response to this rule being resolved
                    [self resolveWithState: state
                                     after: rule];
                }
            } else {
                TTDebug(@"    not resolved ✗");

                [rule didResolve: NO];
                
                if (rule.removedIfNotResolved) {
                    [self removeRule: rule];

                    TTDebug(@"      but removed");
                }
            }
        }
        
        if (self.isEmpty) {
            break;
        }
    }
    
    if (_requiresResolution) {
        TTDebug(@"process from top ⟲");

        // rules should be processed again from top to bottom, processing newest ones first
        [self resolveWithState: state];
    }
}

- (void) resolveWithState: (id) state after: (TTRule *) rule {
    if (self.isEmpty) {
        return;
    }

    NSArray *rules = [NSArray arrayWithArray: _rules];

    for (TTRule *otherRule in [rules reverseObjectEnumerator]) {
        if (otherRule == rule) {
            continue;
        }
        
        if ([otherRule canResolve: state after: rule]) {
            if (!self.isEmpty) {
                // recurse until we have resolved all rules that trigger off each other down the chain, then finally resolve this rule
                [self resolveWithState: state
                                before: otherRule];
            }

            TTDebug(@"  trying to resolve: %@ → %@...", rule, otherRule);

            [otherRule willResolveAfter: rule];
            
            if ([otherRule resolve: state after: rule]) {
                TTDebug(@"    resolved ✓");

                [otherRule didResolve: YES
                                after: rule];
                
                if (!otherRule.persistsWhenResolved) {
                    [self removeRule: otherRule];

                    TTDebug(@"      and removed");
                }
                
                if (!self.isEmpty) {
                    // then resolve any rules that trigger after this rule
                    [self resolveWithState: state
                                     after: otherRule];
                }
            } else {
                TTDebug(@"    not resolved ✗");

                [otherRule didResolve: NO
                                after: rule];
                
                if (otherRule.removedIfNotResolved) {
                    [self removeRule: otherRule];

                    TTDebug(@"      but removed");
                }
            }
        }
        
        if (self.isEmpty) {
            break;
        }
    }
}

@end

