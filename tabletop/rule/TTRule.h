//
//  TTRule.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 07/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTRule;

typedef BOOL (^TTRuleResolutionBlock)(id state);
typedef BOOL (^TTRuleResolutionConditionBlock)(id state);
typedef BOOL (^TTRuleResolutionConditionResponseBlock)(id state, TTRule *otherRule);
typedef BOOL (^TTRuleResolutionResponseBlock)(id state, TTRule *otherRule);

/**
 Represents a rule that can be resolved given the appropriate state or context.
 */
@interface TTRule : NSObject

/**
 Create an empty rule.
 */
+ (TTRule *) rule;
/**
 Create an empty rule with a name.
 */
+ (TTRule *) ruleWithName: (NSString *) name;
/**
 Create a rule that will be resolved in the appropriate state.
 */
+ (TTRule *) ruleWithName: (NSString *) name
             thatResolves: (TTRuleResolutionConditionBlock) condition;
/**
 Create a rule that will be resolved on the next pass.
 */
+ (TTRule *) ruleWithName: (NSString *) name
           thatResolvesTo: (TTRuleResolutionBlock) resolution;
/**
 Create a rule that will be resolved in the appropriate state.
 */
+ (TTRule *) ruleWithName: (NSString *) name
             thatResolves: (TTRuleResolutionConditionBlock) condition
                       to: (TTRuleResolutionBlock) resolution;
/**
 Create a rule that will be resolved before another rule.
 */
+ (TTRule *) ruleWithName: (NSString *) name
       thatResolvesBefore: (TTRuleResolutionConditionResponseBlock) responseCondition
                       to: (TTRuleResolutionResponseBlock) resolution;
/**
 Create a rule that will be resolved before or after another rule.
 */
+ (TTRule *) ruleWithName: (NSString *) name
       thatResolvesBefore: (TTRuleResolutionConditionResponseBlock) responseConditionBefore
                       to: (TTRuleResolutionResponseBlock) resolutionBefore
                  orAfter: (TTRuleResolutionConditionResponseBlock) responseConditionAfter
                       to: (TTRuleResolutionResponseBlock) resolutionAfter;
/**
 Create a rule that will be resolved after another rule.
 */
+ (TTRule *) ruleWithName: (NSString *) name
        thatResolvesAfter: (TTRuleResolutionConditionResponseBlock) responseCondition
                       to: (TTRuleResolutionResponseBlock) resolution;

/**
 Get or set the action that should occur when the rule is being resolved. The action should return YES if the rule was resolved, NO otherwise.
 */
@property (strong) TTRuleResolutionBlock resolutionBlock;
/**
 Get or set a condition that returns YES if the rule should be resolved given the current state. NO otherwise.
 */
@property (strong) TTRuleResolutionConditionBlock resolutionConditionBlock;

/**
 Get or set a condition that returns YES if the rule should be resolved as a response to another rule being resolved. NO otherwise.
 */
@property (strong) TTRuleResolutionConditionResponseBlock resolutionConditionBeforeBlock;
/**
 Get or set a condition that returns YES if the rule should be resolved as a response to another rule having been resolved. NO otherwise.
 */
@property (strong) TTRuleResolutionConditionResponseBlock resolutionConditionAfterBlock;

/**
 Get or set the action that should occur when the rule is being resolved as a response to another rule being resolved. The action should return YES if the rule was resolved, NO otherwise.
 */
@property (strong) TTRuleResolutionResponseBlock resolutionBeforeBlock;
/**
 Get or set the action that should occur when the rule is being resolved as a response to another rule having been resolved. The action should return YES if the rule was resolved, NO otherwise.
 */
@property (strong) TTRuleResolutionResponseBlock resolutionAfterBlock;

/**
 Get or set whether or not the rule should persist after being resolved.
 
 A rule that persists will stay in the rules stack after it has been resolved successfully.
 */
@property (assign) BOOL persistsWhenResolved;

/**
 Get or set whether or not the rule should be removed after not resolving successfully.
 */
@property (assign) BOOL removedIfNotResolved;

/**
 Get or set the name of the rule.
 */
@property (strong) NSString *name;

/**
 Create a new rule with a name.

 @returns A TTRule object.
 */
- (instancetype) initWithName: (NSString *) name;

/**
 Determine whether the rule can be resolved given the current state.
 
 This will always return YES unless a subclass returns differently, or a @c resolutionConditionBlock is defined.
 */
- (BOOL) canResolve: (id) state;
/**
 Determine whether the rule can be resolved as a response to another rule being resolved.
 */
- (BOOL) canResolve: (id) state
             before: (TTRule *) rule;
/**
 Determine whether the rule can be resolved as a response to another rule having been resolved.
 */
- (BOOL) canResolve: (id) state
              after: (TTRule *) rule;

/**
 Resolve the rule.
 
 @returns YES if the rule was resolved, NO otherwise.
 */
- (BOOL) resolve: (id) state;
/**
 Resolve the rule before another rule.

 @returns YES if the rule was resolved, NO otherwise.
 */
- (BOOL) resolve: (id) state
          before: (TTRule *) rule;
/**
 Resolve the rule after another rule.

 @returns YES if the rule was resolved, NO otherwise.
 */
- (BOOL) resolve: (id) state
           after: (TTRule *) rule;

@end
