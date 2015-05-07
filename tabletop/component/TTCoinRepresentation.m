//
//  TTCoinRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 01/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTCoinRepresentation.h"

NSString* const kTTCoinRepresentationIsFlippedKey = @"is_flipped";
NSString* const kTTCoinRepresentationBacksideKey = @"backside";

@implementation TTCoinRepresentation

- (instancetype) init {
    if ((self = [super init])) {
        _isFlipped = NO;
    }

    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _isFlipped = [decoder decodeBoolForKey: kTTCoinRepresentationIsFlippedKey];
        _backside = [decoder decodeObjectForKey: kTTCoinRepresentationBacksideKey];
    }

    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];

    [encoder encodeBool: _isFlipped forKey: kTTCoinRepresentationIsFlippedKey];
    [encoder encodeObject: _backside forKey: kTTCoinRepresentationBacksideKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTCoinRepresentation *component = [super copyWithZone: zone];

    if (component) {
        component.backside = self.backside;

        if (component.isFlipped != self.isFlipped) {
            [component flip];
        }
    }

    return component;
}

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTCoinRepresentation *otherCoinRepresentation = (TTCoinRepresentation *)object;

        return [otherCoinRepresentation.backside isEqual:
                self.backside];
    }

    return NO;
}

- (id<NSCoding, NSObject, NSCopying>) visibleImage {
    return self.isFlipped ?
        self.backside : self.frontside;
}

- (void) flip {
    _isFlipped = !_isFlipped;
}

- (void) flip: (BOOL) randomly {
    _isFlipped = arc4random_uniform((u_int32_t)2) == 1;
}

@end
