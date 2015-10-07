//
//  TTRule.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 07/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTRule;

typedef BOOL (^TTRuleResolutionBlock)(id __nullable state);
typedef BOOL (^TTRuleResolutionConditionBlock)(id __nullable state);
typedef BOOL (^TTRuleResolutionConditionResponseBlock)(id __nullable state, TTRule *__nullable otherRule);
typedef BOOL (^TTRuleResolutionResponseBlock)(id __nullable state, TTRule *__nullable otherRule);

/**
 Represents a rule that can be resolved.
 */
@interface TTRule : NSObject

/**
 Create a rule.
 */
+ (nonnull instancetype) rule;
/**
 Create a rule that will always resolve.
 */
+ (nonnull instancetype) ruleWithName: (nullable NSString *) name;
/**
 Create a rule that will always resolve.
 */
+ (nonnull instancetype) ruleWithName: (nullable NSString *) name
                       thatResolvesTo: (nullable TTRuleResolutionBlock) resolution;
/**
 Create a rule that will resolve when a condition is satisfied.
 */
+ (nonnull instancetype) ruleWithName: (nullable NSString *) name
                         thatResolves: (nullable TTRuleResolutionConditionBlock) condition;
/**
 Create a rule that will resolve when a condition is satisfied.
 */
+ (nonnull instancetype) ruleWithName: (nullable NSString *) name
                         thatResolves: (nullable TTRuleResolutionConditionBlock) condition
                                   to: (nullable TTRuleResolutionBlock) resolution;
/**
 Create a rule that will resolve @a before another rule, if a condition is satisfied.
 */
+ (nonnull instancetype) ruleWithName: (nullable NSString *) name
                   thatResolvesBefore: (nullable TTRuleResolutionConditionResponseBlock) responseCondition
                                   to: (nullable TTRuleResolutionResponseBlock) resolution;
/**
 Create a rule that will resolve either @a before or @a after another rule, if a condition is satisfied.
 */
+ (nonnull instancetype) ruleWithName: (nullable NSString *) name
                   thatResolvesBefore: (nullable TTRuleResolutionConditionResponseBlock) responseConditionBefore
                                   to: (nullable TTRuleResolutionResponseBlock) resolutionBefore
                              orAfter: (nullable TTRuleResolutionConditionResponseBlock) responseConditionAfter
                                   to: (nullable TTRuleResolutionResponseBlock) resolutionAfter;
/**
 Create a rule that will resolve @a after another rule, if a condition is satisfied.
 */
+ (nonnull instancetype) ruleWithName: (nullable NSString *) name
                    thatResolvesAfter: (nullable TTRuleResolutionConditionResponseBlock) responseCondition
                                   to: (nullable TTRuleResolutionResponseBlock) resolution;

/**
 Get or set the action that should occur when the rule resolves. The action should return YES if the rule was resolved successfully, NO otherwise.
 */
@property (nullable, strong) TTRuleResolutionBlock resolutionBlock;
/**
 Get or set a condition that returns YES if the rule should be resolved given the current state. NO otherwise.
 */
@property (nullable, strong) TTRuleResolutionConditionBlock resolutionConditionBlock;

/**
 Get or set a condition that returns YES if the rule should be resolved as a response to another rule being resolved. NO otherwise.
 */
@property (nullable, strong) TTRuleResolutionConditionResponseBlock resolutionConditionBeforeBlock;
/**
 Get or set a condition that returns YES if the rule should be resolved as a response to another rule having been resolved. NO otherwise.
 */
@property (nullable, strong) TTRuleResolutionConditionResponseBlock resolutionConditionAfterBlock;

/**
 Get or set the action that should occur when the rule resolves as a response to another rule being resolved. The action should return YES if the rule was resolved, NO otherwise.
 */
@property (nullable, strong) TTRuleResolutionResponseBlock resolutionBeforeBlock;
/**
 Get or set the action that should occur when the rule is being resolved as a response to another rule having been resolved. The action should return YES if the rule was resolved, NO otherwise.
 */
@property (nullable, strong) TTRuleResolutionResponseBlock resolutionAfterBlock;

/**
 Get or set whether or not the rule should persist @a after having been resolved.
 
 A rule that persists will stay in the rule stack after it has been resolved successfully.
 */
@property (assign) BOOL persistsWhenResolved;

/**
 Get or set whether or not the rule should be removed after @a not resolving successfully.
 */
@property (assign) BOOL removedIfNotResolved;

/**
 Get or set the name of the rule.
 */
@property (nullable, strong) NSString *name;

/**
 Create a new rule with a name.

 @returns A TTRule object.
 */
- (nonnull instancetype) initWithName: (nullable NSString *) name;

/**
 Determine whether the rule can be resolved given the current state.
 
 This will always return YES unless a subclass returns differently, or a @c resolutionConditionBlock is defined.
 */
- (BOOL) canResolve: (nullable id) state;
/**
 Determine whether the rule can be resolved as a response to another rule being resolved.
 */
- (BOOL) canResolve: (nullable id) state
             before: (nonnull TTRule *) rule;
/**
 Determine whether the rule can be resolved as a response to another rule having been resolved.
 */
- (BOOL) canResolve: (nullable id) state
              after: (nonnull TTRule *) rule;

/**
 Called before the rule attempts to resolve as a response to another rule being resolved.
 
 Override this method in a subclass to implement behavior before a resolution attempt.
 
 The default implementation of this method does nothing.
 */
- (void) willResolveBefore: (nonnull TTRule *) rule;
/**
 Called before the rule attempts to resolve.
 
 Override this method in a subclass to implement behavior before a resolution attempt.
 
 The default implementation of this method does nothing.
 */
- (void) willResolve;
/**
 Called before the rule attempts to resolve as a response to another rule having been resolved.
 
 Override this method in a subclass to implement behavior before a resolution attempt.
 
 The default implementation of this method does nothing.
 */
- (void) willResolveAfter: (nonnull TTRule *) rule;

/**
 Resolve the rule.
 
 @returns YES if the rule was resolved, NO otherwise.
 */
- (BOOL) resolve: (nullable id) state;
/**
 Resolve the rule before another rule.
 
 @returns YES if the rule was resolved, NO otherwise.
 */
- (BOOL) resolve: (nullable id) state
          before: (nonnull TTRule *) rule;
/**
 Resolve the rule after another rule.
 
 @returns YES if the rule was resolved, NO otherwise.
 */
- (BOOL) resolve: (nullable id) state
           after: (nonnull TTRule *) rule;

/**
 Called after the rule has been resolved (either successfully or not) as a response to another rule being resolved.
 
 Override this method in a subclass to implement behavior after a resolution attempt.
 
 The default implementation of this method does nothing.
 */
- (void) didResolve: (BOOL) successfully
             before: (nonnull TTRule *) rule;
/**
 Called after the rule has been resolved (either successfully or not).
 
 Override this method in a subclass to implement behavior after a resolution attempt.
 
 The default implementation of this method does nothing.
 */
- (void) didResolve: (BOOL) successfully;
/**
 Called after the rule has been resolved (either successfully or not) as a response to another rule having been resolved.
 
 Override this method in a subclass to implement behavior after a resolution attempt.
 
 The default implementation of this method does nothing.
 */
- (void) didResolve: (BOOL) successfully
              after: (nonnull TTRule *) rule;

@end
