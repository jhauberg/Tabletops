//
//  TTRuleStack.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 09/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTRule.h"

/**
 Provides a mechanism for recursively resolving a chain of rules.
 */
@interface TTRuleStack : NSObject

/**
 Determine whether there's any rules to be processed.
 */
@property (readonly) BOOL isEmpty;

/**
 Push a rule to the top of the stack.

 @returns YES if the rule was added to the top of the stack, NO otherwise.
 */
- (BOOL) push: (TTRule *) rule;
/**
 Push a rule to the top of the stack. The rule will be resolved in response to another rule being resolved.
 
 @returns YES if the rule was added to the top of the stack, NO otherwise.
 */
- (BOOL) push: (TTRule *) rule before: (TTRule *) otherRule;
/**
 Push a rule to the top of the stack. The rule will be resolved in response to another rule with the given name being resolved.
 
 @returns YES if the rule was added to the top of the stack, NO otherwise.
 */
- (BOOL) push: (TTRule *) rule beforeRuleNamed: (NSString *) otherRuleName;
/**
 Push a rule to the top of the stack. The rule will be resolved in response to another rule having been resolved.
 
 @returns YES if the rule was added to the top of the stack, NO otherwise.
 */
- (BOOL) push: (TTRule *) rule after: (TTRule *) otherRule;
/**
 Push a rule to the top of the stack. The rule will be resolved in response to another rule with the given name having been resolved.
 
 @returns YES if the rule was added to the top of the stack, NO otherwise.
 */
- (BOOL) push: (TTRule *) rule afterRuleNamed: (NSString *) otherRuleName;

/**
 Push rules to the top of the stack.
 
 Note that even if this returns NO, some rules may have been added.

 @returns YES if all the rules were added to the stack, NO otherwise.
 */
- (BOOL) pushRules: (NSArray *) rules;

/**
 Push rules to the top of the stack in an ordered sequence, so that the first rule in the sequence will be resolved first.
 
 Note that even if this returns NO, some rules may have been added.
 
 @returns YES if all the rules were added to the stack, NO otherwise.
 */
- (BOOL) pushRuleSequence: (NSArray *) ruleSequence;
/**
 Push rules to the top of the stack in an ordered sequence, so that the first rule in the sequence will be resolved first. The rules will be resolved in response to another rule being resolved.
 
 Note that even if this returns NO, some rules may have been added.
 
 @returns YES if all the rules were added to the stack, NO otherwise.
 */
- (BOOL) pushRuleSequence: (NSArray *) ruleSequence before: (TTRule *) otherRule;
/**
 Push rules to the top of the stack in an ordered sequence, so that the first rule in the sequence will be resolved first. The rules will be resolved in response to another rule having been resolved.
 
 Note that even if this returns NO, some rules may have been added.
 
 @returns YES if all the rules were added to the stack, NO otherwise.
 */
- (BOOL) pushRuleSequence: (NSArray *) ruleSequence after: (TTRule *) otherRule;

/**
 Remove all rules from the stack.
 */
- (void) removeAllRules;
/**
 Remove all rules except the specified @c rule from the stack.
 */
- (void) removeAllRulesExcept: (TTRule *) rule;
/**
 Remove all rules except the specified @c rules from the stack.
 */
- (void) removeAllRulesExceptRules: (NSArray *) rules;

/**
 Process and attempt to resolve all rules in the stack.
 
 The rules on top (the rules most recently added; i.e. the last) will be processed first.
 */
- (void) resolveWithState: (id) state;

@end
