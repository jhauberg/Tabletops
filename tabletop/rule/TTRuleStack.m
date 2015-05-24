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
    if (![_rules containsObject: rule]) {
#ifdef SHOW_RUNTIME_WARNINGS
        NSLog(@" *** Rule '%@' is not in the rule stack. It was not removed.", rule);
#endif
        return NO;
    }

    [_rules removeObject: rule];

    return YES;
}

- (BOOL) push: (TTRule *) rule {
    if (rule == nil || [_rules containsObject: rule]) {
#ifdef SHOW_RUNTIME_WARNINGS
        NSLog(@" *** Rule '%@' is already in the rule stack. It was not added.", rule);
#endif
        return NO;
    }

    [_rules addObject: rule];

    // a new rule may be pushed during the resolution of another rule, so this is set
    // in order to trigger another resolution pass at the end of the current pass (if any)
    _requiresResolution = YES;

    return YES;
}

- (TTRuleResolutionConditionResponseBlock) conditionForRule: (TTRule *) rule thatRespondsToRule: (TTRule *) triggerRule {
    return ^BOOL(id state, TTRule *anotherRule) {
        BOOL shouldTriggerInResponseToRule = [anotherRule.name isEqualToString: triggerRule.name] || [anotherRule isEqual: triggerRule];

        if (shouldTriggerInResponseToRule) {
            if (rule.resolutionConditionBlock) {
                return rule.resolutionConditionBlock(state);
            }

            return YES;
        }

        return NO;
    };
}

- (BOOL) push: (TTRule *) rule before: (TTRule *) otherRule {
    if ([self push: rule]) {
        __weak typeof(rule) weakRule = rule;

#ifdef SHOW_RUNTIME_WARNINGS
        if (rule.resolutionConditionBlock) {
            NSLog(@" *** Rule '%@' that should trigger before '%@' already has a resolution condition. It might resolve unexpectedly.", rule.name, otherRule.name);
        }
#endif

        rule.resolutionConditionBeforeBlock = [self conditionForRule: rule
                                                  thatRespondsToRule: otherRule];
        
        if (!rule.resolutionBeforeBlock) {
            if (rule.resolutionBlock) {
                rule.resolutionBeforeBlock = ^BOOL(id state, TTRule *anotherRule) {
                    if (weakRule.resolutionBlock) {
                        return weakRule.resolutionBlock(state);
                    }
                    
                    return NO;
                };
            } else {
                rule.resolutionBeforeBlock = ^BOOL(id state, TTRule *anotherRule) {
                    return YES;
                };
            }
        }
        
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
        __weak typeof(rule) weakRule = rule;

#ifdef SHOW_RUNTIME_WARNINGS
        if (rule.resolutionConditionBlock) {
            NSLog(@" *** Rule '%@' that should trigger after '%@' already has a resolution condition. It might resolve unexpectedly.", rule.name, otherRule.name);
        }
#endif

        rule.resolutionConditionAfterBlock = [self conditionForRule: rule
                                                 thatRespondsToRule: otherRule];
        
        if (!rule.resolutionAfterBlock) {
            if (rule.resolutionBlock) {
                rule.resolutionAfterBlock = ^BOOL(id state, TTRule *anotherRule) {
                    if (weakRule.resolutionBlock) {
                        return weakRule.resolutionBlock(state);
                    }
                    
                    return NO;
                };
            } else {
                rule.resolutionAfterBlock = ^BOOL(id state, TTRule *anotherRule) {
                    return YES;
                };
            }
        }
        
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
            
            NSLog(@"  trying to resolve: %@ ← %@...", otherRule, rule);
            
            if ([otherRule resolve: state before: rule]) {
                NSLog(@"    resolved ✓");
                
                if (!otherRule.persistsWhenResolved) {
                    [self removeRule: otherRule];
                    
                    NSLog(@"      and removed");
                }
                
                if (!self.isEmpty) {
                    // then resolve any rules that trigger after this rule
                    [self resolveWithState: state
                                     after: otherRule];
                }
            } else {
                NSLog(@"    not resolved ✗");
                
                if (otherRule.removedIfNotResolved) {
                    [self removeRule: otherRule];
                    
                     NSLog(@"      but removed");
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
        NSLog(@"no rules to process");
        
        return;
    }
    
    NSLog(@"processing rules...");

    NSArray *rules = [NSArray arrayWithArray: _rules];

    // go through all processable rules, from top to bottom; first in, last out.
    for (TTRule *rule in [rules reverseObjectEnumerator]) {
        NSLog(@"processing: %@", rule);
        
        // determine if the rule can resolve with the current game state
        if ([rule canResolve: state]) {
            if (!self.isEmpty) {
                // before resolving the rule, determine if any other rules should resolve in response to this rule resolving
                [self resolveWithState: state
                                before: rule];
            }

            NSLog(@"  trying to resolve: %@...", rule);
            
            // then finally resolve the rule
            if ([rule resolve: state]) {
                NSLog(@"    resolved ✓");
                
                if (!rule.persistsWhenResolved) {
                    [self removeRule: rule];
                    
                    NSLog(@"      and removed");
                }
                
                if (!self.isEmpty) {
                    // after resolving the rule, determine if any other rules should resolve in response to this rule being resolved
                    [self resolveWithState: state
                                     after: rule];
                }
            } else {
                NSLog(@"    not resolved ✗");
                
                if (rule.removedIfNotResolved) {
                    [self removeRule: rule];
                    
                    NSLog(@"      but removed");
                }
            }
        }
        
        if (self.isEmpty) {
            break;
        }
    }
    
    if (_requiresResolution) {
        _requiresResolution = NO;
        
        NSLog(@"process from top ⟲");
        
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
            
            NSLog(@"  trying to resolve: %@ → %@...", rule, otherRule);
            
            if ([otherRule resolve: state after: rule]) {
                NSLog(@"    resolved ✓");
                
                if (!otherRule.persistsWhenResolved) {
                    [self removeRule: otherRule];
                    
                    NSLog(@"      and removed");
                }
                
                if (!self.isEmpty) {
                    // then resolve any rules that trigger after this rule
                    [self resolveWithState: state
                                     after: otherRule];
                }
            } else {
                NSLog(@"    not resolved ✗");
                
                if (otherRule.removedIfNotResolved) {
                    [self removeRule: otherRule];
                    
                    NSLog(@"      but removed");
                }
            }
        }
        
        if (self.isEmpty) {
            break;
        }
    }
}

@end

