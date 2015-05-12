//
//  TTPropertyComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTPropertyComponent.h"

NSString* const kTTPropertyComponentNameKey = @"name";
NSString* const kTTPropertyComponentValueKey = @"value";

@implementation TTPropertyComponent

+ (instancetype) propertyWithName: (NSString *) name andValue: (id<NSCoding, NSObject, NSCopying>) value {
    return [[[self class] alloc] initWithName: name
                                     andValue: value];
}

- (instancetype) initWithName: (NSString *) name andValue: (id<NSCoding, NSObject, NSCopying>) value {
    if ((self = [super init])) {
        _name = name;
        _value = value;
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _name = [decoder decodeObjectForKey: kTTPropertyComponentNameKey];
        _value = [decoder decodeObjectForKey: kTTPropertyComponentValueKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _name forKey: kTTPropertyComponentNameKey];
    [encoder encodeObject: _value forKey: kTTPropertyComponentValueKey];
}

- (NSNumber *) numberValue {
    NSNumber *numberValue = nil;

    SEL doubleSelector = @selector(doubleValue);

    if ([self.value respondsToSelector: doubleSelector]) {
        NSMethodSignature *signature = [NSString instanceMethodSignatureForSelector: doubleSelector];

        if (signature) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: signature];

            if (invocation) {
                [invocation setTarget: self.value];
                [invocation setSelector: doubleSelector];
                [invocation invoke];

                double currentValue = 0;

                [invocation getReturnValue: &currentValue];

                numberValue = @(currentValue);
            }
        }
    }

    return numberValue;
}

- (NSString *) stringValue {
    NSString *stringValue = nil;

    if ([self.value isKindOfClass: [NSString class]]) {
        stringValue = (NSString *)self.value;
    } else {
        if ([self.value respondsToSelector: @selector(stringValue)]) {
            stringValue = (NSString *)[self.value performSelector: @selector(stringValue)
                                                       withObject: nil];
        }
    }

    return stringValue;
}

- (NSComparisonResult) compare: (TTPropertyComponent *) otherProperty {
    if ([self isLike: otherProperty]) {
        if (self.numberValue && otherProperty.numberValue) {
            return [self.numberValue compare:
                    otherProperty.numberValue];
        } else if (self.stringValue && otherProperty.stringValue) {
            return [self.stringValue compare:
                    otherProperty.stringValue];
        } else if ([self.value isKindOfClass: [NSArray class]] &&
                   [otherProperty.value isKindOfClass: [NSArray class]]) {
            NSArray *valueArray = (NSArray *)self.value;
            NSArray *otherValueArray = (NSArray *)otherProperty.value;
            
            if (valueArray.count > otherValueArray.count) {
                return NSOrderedDescending;
            } else if (valueArray.count < otherValueArray.count) {
                return NSOrderedAscending;
            } else {
                return NSOrderedSame;
            }
        }
    }
    
    return NSOrderedSame;
}

/**
 A different property component is considered to be equal to the receiver only if both name and value are the same.
 */
- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTPropertyComponent *otherPropertyComponent = (TTPropertyComponent *)object;
        
        return
            [self.name isEqual: otherPropertyComponent.name] &&
            [self.value isEqual: otherPropertyComponent.value];
    }
    
    return NO;
}

/**
 A different property component is considered to be like the receiver only if the name is the same.
 */
- (BOOL) isLike: (TTEntityComponent *) otherComponent {
    if ([super isLike: otherComponent]) {
        TTPropertyComponent *otherPropertyComponent = (TTPropertyComponent *)otherComponent;
        
        return [self.name isEqual:
                otherPropertyComponent.name];
    }
    
    return NO;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"%@ %@ = %@", [super description], self.name, self.value];
}

- (NSString *) shortDescription {
    return [NSString stringWithFormat:
            @"%@ (%@ = %@)", [super shortDescription], self.name, self.value];
}

@end
