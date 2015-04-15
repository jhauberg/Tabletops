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

- (id) copyWithZone: (NSZone *) zone {
    return [[[self class] allocWithZone: zone] initWithName: self.name
                                                   andValue: self.value];
}

- (NSComparisonResult) compare: (TTPropertyComponent *) otherProperty {
    if ([self isLike: otherProperty]) {
        if ([self.value isKindOfClass: [NSNumber class]] &&
            [otherProperty.value isKindOfClass: [NSNumber class]]) {
            return [((NSNumber *)self.value) compare:
                    (NSNumber *)otherProperty.value];
        } else if ([self.value isKindOfClass: [NSString class]] &&
                   [otherProperty.value isKindOfClass: [NSString class]]) {
            return [((NSString *)self.value) compare:
                    (NSString *)otherProperty.value];
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
            @"%@ %@=%@", [super description], self.name, self.value];
}

@end
