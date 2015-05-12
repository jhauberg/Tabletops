//
//  TTPlayerEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 24/11/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTPlayerEntity.h"

NSString* const kTTPlayerEntityNameKey = @"name";
NSString* const kTTPlayerEntityNameValueKey = @"name_value";
NSString* const kTTPlayerEntityHandKey = @"hand";

@implementation TTPlayerEntity {
 @private
    TTPropertyComponent *_name;
    TTHandGroupingComponent *_hand;

    NSString *_nameValue;
}

+ (instancetype) playerWithName: (NSString *) name {
    return [[[self class] alloc] initWithName: name];
}

- (instancetype) init {
    return [self initWithName: @"John Doe"];
}

- (instancetype) initWithName: (NSString *) name {
    if ((self = [super init])) {
        _nameValue = name;
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _name = [decoder decodeObjectForKey: kTTPlayerEntityNameKey];
        _hand = [decoder decodeObjectForKey: kTTPlayerEntityHandKey];
        _nameValue = [decoder decodeObjectForKey: kTTPlayerEntityNameValueKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _name forKey: kTTPlayerEntityNameKey];
    [encoder encodeObject: _hand forKey: kTTPlayerEntityHandKey];
    [encoder encodeObject: _nameValue forKey: kTTPlayerEntityNameValueKey];
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == _name ||
        component == _hand) {
        return NO;
    }
    
    return [super removeComponent: component];
}

- (TTPropertyComponent *) name {
    if (!_name) {
        _name = [TTPropertyComponent propertyWithName: @"Name"
                                             andValue: _nameValue];

        [self addComponent: _name];
    }

    return _name;
}

- (TTHandGroupingComponent *) hand {
    if (!_hand) {
        _hand = [[TTHandGroupingComponent alloc] initWithOwner: self];

        [self addComponent: _hand];
    }

    return _hand;
}

@end
