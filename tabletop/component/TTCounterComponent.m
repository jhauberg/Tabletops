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

- (id) initWithName: (NSString *) name andValue: (id<NSCoding, NSObject, NSCopying>) value {
    if (value) {
        if ([value isKindOfClass: [NSString class]]) {
            value = @([(NSString *)value doubleValue]);
        }
        
        if (![value isKindOfClass: [NSNumber class]]) {
            [NSException raise: @"Invalid value"
                        format: @"'%@' must be a number value", value];
        }
    }
    
    if ((self = [super initWithName: name
                           andValue: value])) {
        
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
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
    TTCounterComponent *component = [[[self class] allocWithZone: zone] init];
    
    if (component) {
        component.step = self.step;
    }
    
    return component;
}

- (BOOL) incrementBy: (double) amount {
    if (self.step) {
        self.value = @([(NSNumber *)self.value doubleValue] + amount);
        
        return YES;
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
