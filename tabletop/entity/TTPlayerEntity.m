//
//  TTPlayerEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 24/11/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTPlayerEntity.h"

NSString* const kTTPlayerEntityHandKey = @"hand";

@implementation TTPlayerEntity {
 @private
    TTHandGroupingComponent *_hand;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _hand = [decoder decodeObjectForKey: kTTPlayerEntityHandKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];

    [encoder encodeObject: _hand forKey: kTTPlayerEntityHandKey];
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == _hand) {
        return NO;
    }
    
    return [super removeComponent: component];
}

- (TTHandGroupingComponent *) hand {
    if (!_hand) {
        _hand = [[TTHandGroupingComponent alloc] initWithOwner: self];

        [self addComponent: _hand];
    }

    return _hand;
}

@end
