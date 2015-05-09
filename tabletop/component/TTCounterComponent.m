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

- (BOOL) incrementBy: (NSNumber *) amount {
    if (amount) {
#ifdef DEBUG
        if ([amount doubleValue] < 0) {
            NSLog(@" *** Attempting to increment '%@' by a negative value ('%@') will cause a decrement instead. Are you sure this is intended?", self, amount);
        }
#endif
        if (!self.numberValue) {
            [NSException raise: @"Invalid value"
                        format: @"'%@' must be a number value", self.value];
        } else {
            self.value = @([self.numberValue doubleValue] + [amount doubleValue]);

            return YES;
        }
    }
    
    return NO;
}

- (BOOL) decrementBy: (NSNumber *) amount {
    if (amount) {
#ifdef DEBUG
        if ([amount doubleValue] < 0) {
            NSLog(@" *** Attempting to decrement '%@' by a negative value ('%@') causes an increment instead. Are you sure this is intended?", self, amount);
        }
#endif
        if (!self.numberValue) {
            [NSException raise: @"Invalid value"
                        format: @"'%@' must be a number value", self.value];
        } else {
            self.value = @([self.numberValue doubleValue] - [amount doubleValue]);

            return YES;
        }
    }

    return NO;
}

- (BOOL) increment {
    return [self incrementBy:
            self.step];
}

- (BOOL) decrement {
    return [self incrementBy:
            @(-[self.step doubleValue])];
}

@end
