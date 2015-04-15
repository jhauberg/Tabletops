//
//  TTDeckEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 19/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDeckEntity.h"

NSString* const kTTDeckEntityGroupKey = @"group";

@implementation TTDeckEntity {
 @private
    TTDeckGroupingComponent *_group;
}

+ (instancetype) deck {
    return [[[self class] alloc] init];
}

- (instancetype) init {
    if ((self = [super init])) {
        if (!_group) {
            _group = [[TTDeckGroupingComponent alloc] init];
        }
        
        [self addComponent: _group];
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _group = [decoder decodeObjectForKey: kTTDeckEntityGroupKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _group forKey: kTTDeckEntityGroupKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTDeckEntity *entity = [[[self class] allocWithZone: zone] init];
    
    if (entity) {
        for (TTEntity *groupedEntity in self.group.entities) {
            [entity.group addEntity:
             [groupedEntity copyWithZone: zone]];
        }
    }
    
    return entity;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == self.group) {
        return NO;
    }
    
    return [super removeComponent: component];
}

- (TTDeckGroupingComponent *) group {
    return _group;
}

@end
