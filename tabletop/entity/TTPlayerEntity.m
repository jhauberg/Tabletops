//
//  TTPlayerEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 24/11/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTPlayerEntity.h"

NSString* const kTTPlayerEntityNameKey = @"name";
NSString* const kTTPlayerEntityHandKey = @"hand";

@implementation TTPlayerEntity {
 @private
    TTPropertyComponent *_name;
    TTHandGroupingComponent *_hand;
}

+ (instancetype) playerWithName: (NSString *) name {
    return [[[self class] alloc] initWithName: name];
}

- (instancetype) init {
    return [self initWithName: @"John Doe"];
}

- (instancetype) initWithName: (NSString *) name {
    if ((self = [super init])) {
        if (!_name) {
            _name = [[TTPropertyComponent alloc] initWithName: @"Name"
                                                     andValue: name];
        }
        
        if (!_hand) {
            _hand = [[TTHandGroupingComponent alloc] initWithOwner: self];
        }
        
        [self addComponent: _name];
        [self addComponent: _hand];
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _name = [decoder decodeObjectForKey: kTTPlayerEntityNameKey];
        _hand = [decoder decodeObjectForKey: kTTPlayerEntityHandKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _name forKey: kTTPlayerEntityNameKey];
    [encoder encodeObject: _hand forKey: kTTPlayerEntityHandKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTPlayerEntity *player = [[[self class] allocWithZone: zone] initWithName: (NSString *)self.name.value];
    
    if (player) {
        for (TTEntity *entityInHand in self.hand.entities) {
            [player.hand addEntity:
             [entityInHand copyWithZone: zone]];
        }
    }
    
    return player;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == self.name ||
        component == self.hand) {
        return NO;
    }
    
    return [super removeComponent: component];
}

- (TTPropertyComponent *) name {
    return _name;
}

- (TTHandGroupingComponent *) hand {
    return _hand;
}

@end
