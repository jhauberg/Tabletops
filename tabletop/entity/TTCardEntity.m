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

+ (instancetype) cardWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside
                       andBackside: (id<NSCoding, NSObject, NSCopying>) backside {
    return [self cardWithFrontside: frontside
                       andBackside: backside
             withFrontsideFacingUp: YES];
}

+ (instancetype) cardWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside
                       andBackside: (id<NSCoding, NSObject, NSCopying>) backside
             withFrontsideFacingUp: (BOOL) faceUp {
    TTCardEntity *card = [self entity];

    if (card) {
        card.representation.frontside = frontside;
        card.representation.backside = backside;

        if (faceUp) {
            [card.representation flipToFrontside];
        }
    }

    return card;
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

- (TTCardRepresentation *) representation {
    if (!_representation) {
        _representation = [TTCardRepresentation representation];

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
