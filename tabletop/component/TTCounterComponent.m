//
//  TTCounterComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 26/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTCounterComponent.h"

NSString* const kTTCounterComponentStepKey = @"step";

@implementation TTCounterComponent

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _step = [decoder decodeObjectForKey: kTTCounterComponentStepKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _step forKey: kTTCounterComponentStepKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTCounterComponent *component = [super copyWithZone: zone];
    
    if (component) {
        component.step = self.step;
    }
    
    return component;
}

- (BOOL) incrementBy: (double) amount {
    if (self.step) {
        SEL valueSelector = @selector(doubleValue);
        
        if ([self.value respondsToSelector: valueSelector]) {
            NSMethodSignature *signature = [NSString instanceMethodSignatureForSelector: valueSelector];
            
            if (signature) {
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: signature];
                
                if (invocation) {
                    [invocation setTarget: self.value];
                    [invocation setSelector: valueSelector];
                    [invocation invoke];
                    
                    double currentValue = 0;
                    
                    [invocation getReturnValue: &currentValue];
                    
                    self.value = @(currentValue + amount);
                    
                    return YES;
                }
            }
        } else {
            [NSException raise: @"Invalid value"
                        format: @"'%@' must be a number value", self.value];
        }
    }
    
    return NO;
}

- (BOOL) increment {
    return [self incrementBy:
            [self.step doubleValue]];
}

- (BOOL) decrement {
    return [self incrementBy:
            -[self.step doubleValue]];
}

@end
