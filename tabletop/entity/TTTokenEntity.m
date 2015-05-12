//
//  TTTokenEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 12/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTokenEntity.h"

NSString* const kTTTokenEntityRepresentationKey = @"representation";

@implementation TTTokenEntity {
@private
    TTTokenRepresentation *_representation;
}

+ (instancetype) tokenWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside {
    TTTokenEntity *token = [self entity];

    if (token) {
        token.representation.frontside = frontside;
    }

    return token;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _representation = [decoder decodeObjectForKey: kTTTokenEntityRepresentationKey];
    }

    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];

    [encoder encodeObject: _representation forKey: kTTTokenEntityRepresentationKey];
}

- (TTTokenRepresentation *) representation {
    if (!_representation) {
        _representation = [TTTokenRepresentation representation];

        [self addComponent: _representation];
    }

    return _representation;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == _representation) {
        return NO;
    }

    return [super removeComponent: component];
}

@end
