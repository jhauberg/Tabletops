//
//  TTTableEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTableEntity.h"

NSString* const kTTTableEntityGroupKey = @"group";

@implementation TTTableEntity {
 @private
    TTEntityGroupingComponent *_group;
}

+ (instancetype) table {
    return [[[self class] alloc] init];
}

- (instancetype) init {
    if ((self = [super init])) {
        if (!_group) {
            _group = [[TTEntityGroupingComponent alloc] init];
        }
        
        [self addComponent: _group];
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _group = [decoder decodeObjectForKey: kTTTableEntityGroupKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _group forKey: kTTTableEntityGroupKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTTableEntity *entity = [[[self class] allocWithZone: zone] init];
    
    if (entity) {
        for (TTEntity *groupedEntity in self.group.entities) {
            [entity.group addEntity:
             [groupedEntity copyWithZone: zone]];
        }
    }
    
    return entity;
}

- (BOOL) clear {
    if (_group && [_group removeAllEntities]) {
        return YES;
    }
    
    return NO;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == self.group) {
        return NO;
    }
    
    return [super removeComponent: component];
}

- (TTEntityGroupingComponent *) group {
    return _group;
}

@end
