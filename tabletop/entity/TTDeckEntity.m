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

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == _group) {
        return NO;
    }
    
    return [super removeComponent: component];
}

- (TTDeckGroupingComponent *) group {
    if (!_group) {
        _group = [TTDeckGroupingComponent group];

        [self addComponent: _group];
    }
    
    return _group;
}

@end
