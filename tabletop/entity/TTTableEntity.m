//
//  TTTableEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTableEntity.h"

NSString* const kTTTableEntityGroupingKey = @"grouping";

@implementation TTTableEntity {
 @private
    TTEntityGroupingComponent *_grouping;
}

+ (TTTableEntity *) table {
    return [[TTTableEntity alloc] init];
}

- (id) init {
    if ((self = [super init])) {
        if (!_grouping) {
            _grouping = [[TTEntityGroupingComponent alloc] init];
        }
        
        [self addComponent: _grouping];
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _grouping = [decoder decodeObjectForKey: kTTTableEntityGroupingKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _grouping forKey: kTTTableEntityGroupingKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTTableEntity *entity = [[[self class] allocWithZone: zone] init];
    
    if (entity) {
        for (TTEntity *groupedEntity in self.grouping.entities) {
            [entity.grouping addEntity:
             [groupedEntity copyWithZone: zone]];
        }
    }
    
    return entity;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == self.grouping) {
        return NO;
    }
    
    return [super removeComponent: component];
}

- (TTEntityGroupingComponent *) grouping {
    return _grouping;
}

@end
