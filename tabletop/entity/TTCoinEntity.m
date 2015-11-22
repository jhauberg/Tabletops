//
//  TTCoinEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 14/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTCoinEntity.h"

NSString* const kTTCoinEntityRepresentationKey = @"representation";

@implementation TTCoinEntity {
@private
    TTCoinRepresentation *_representation;
}

+ (instancetype) coinWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside
                       andBackside: (id<NSCoding, NSObject, NSCopying>) backside {
    TTCoinEntity *coin = [self entity];

    if (coin) {
        coin.representation.frontside = frontside;
        coin.representation.backside = backside;
    }

    return coin;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _representation = [decoder decodeObjectForKey: kTTCoinEntityRepresentationKey];
    }

    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];

    [encoder encodeObject: _representation forKey: kTTCoinEntityRepresentationKey];
}

- (TTCoinRepresentation *) representation {
    if (!_representation) {
        _representation = [TTCoinRepresentation representation];

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
