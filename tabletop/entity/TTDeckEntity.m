//
//  TTDeckEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 19/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDeckEntity.h"

NSString* const kTTDeckEntityGroupingKey = @"grouping";

@implementation TTDeckEntity {
 @private
    TTDeckGroupingComponent *_grouping;
}

- (id) init {
    if ((self = [super init])) {
        if (!_grouping) {
            _grouping = [[TTDeckGroupingComponent alloc] init];
        }
        
        [self addComponent: _grouping];
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _grouping = [decoder decodeObjectForKey: kTTDeckEntityGroupingKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: _grouping forKey: kTTDeckEntityGroupingKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTDeckEntity *entity = [[[self class] allocWithZone: zone] init];
    
    if (entity) {
        for (TTEntity *groupedEntity in self.grouping.entities) {
            [entity.grouping addEntity:
             [groupedEntity copyWithZone: zone]];
        }
    }
    
    return entity;
}

- (TTDeckGroupingComponent *) grouping {
    return _grouping;
}

@end
