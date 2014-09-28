//
//  TTTableEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTableEntity.h"

@implementation TTTableEntity {
 @private
    TTEntityGroupingComponent *_grouping;
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
        _grouping = [decoder decodeObjectForKey: @"grouping"];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: _grouping forKey: @"grouping"];
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

- (TTEntityGroupingComponent *) grouping {
    return _grouping;
}

@end
