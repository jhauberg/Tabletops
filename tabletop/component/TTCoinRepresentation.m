//
//  TTCoinRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 01/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTCoinRepresentation.h"

NSString* const kTTCoinRepresentationBackImageKey = @"back_image";

@implementation TTCoinRepresentation

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _backImage = [decoder decodeObjectForKey: kTTCoinRepresentationBackImageKey];
    }

    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];

    [encoder encodeObject: _backImage forKey: kTTCoinRepresentationBackImageKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTCoinRepresentation *component = [super copyWithZone: zone];

    if (component) {
        component.backImage = self.backImage;
    }

    return component;
}

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTCoinRepresentation *otherCoinRepresentation = (TTCoinRepresentation *)object;

        return [self.backImage isEqualToString:
                otherCoinRepresentation.backImage];
    }

    return NO;
}

- (NSString *) visibleImage {
    return self.isFlipped ?
        self.backImage : self.frontImage;
}

- (void) flip {
    _isFlipped = !_isFlipped;
}

- (void) flip: (BOOL) randomly {
    _isFlipped = arc4random_uniform((u_int32_t)2) == 1;
}

@end
