//
//  TTCardEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 16/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTCardEntity.h"

NSString* const kTTCardEntityRepresentationKey = @"representation";

@implementation TTCardEntity {
 @private
    TTCardRepresentation *_representation;
}

+ (instancetype) card {
    return [[[self class] alloc] init];
}

- (instancetype) init {
    if ((self = [super init])) {

    }

    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _representation = [decoder decodeObjectForKey: kTTCardEntityRepresentationKey];
    }

    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];

    [encoder encodeObject: _representation forKey: kTTCardEntityRepresentationKey];
}

- (id) copyWithZone: (NSZone *) zone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:
            [NSKeyedArchiver archivedDataWithRootObject:
             self]];
}

- (TTCardRepresentation *) representation {
    if (!_representation) {
        _representation = [[TTCardRepresentation alloc] init];

        [self addComponent: _representation];
    }

    return _representation;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == self.representation) {
        return NO;
    }

    return [super removeComponent: component];
}

@end
