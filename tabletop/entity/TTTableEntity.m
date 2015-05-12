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

- (BOOL) clear {
    if (_group && [_group removeAllEntities]) {
        return YES;
    }
    
    return NO;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == _group) {
        return NO;
    }
    
    return [super removeComponent: component];
}

- (TTEntityGroupingComponent *) group {
    if (!_group) {
        _group = [TTEntityGroupingComponent group];

        [self addComponent: _group];
    }

    return _group;
}

@end
