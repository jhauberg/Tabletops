//
//  TTCardRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTCardRepresentation.h"

NSString* const kTTCardRepresentationFrontImageKey = @"front_image";
NSString* const kTTCardRepresentationBackImageKey = @"back_image";
NSString* const kTTCardRepresentationIsFaceUpKey = @"is_face_up";
NSString* const kTTCardRepresentationIsTappedKey = @"is_tapped";

@implementation TTCardRepresentation

- (instancetype) init {
    if ((self = [super init])) {
        _isFaceUp = YES;
    }

    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _frontImage = [decoder decodeObjectForKey: kTTCardRepresentationFrontImageKey];
        _backImage = [decoder decodeObjectForKey: kTTCardRepresentationBackImageKey];
        _isFaceUp = [decoder decodeBoolForKey: kTTCardRepresentationIsFaceUpKey];
        _isTapped = [decoder decodeBoolForKey: kTTCardRepresentationIsTappedKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _frontImage forKey: kTTCardRepresentationFrontImageKey];
    [encoder encodeObject: _backImage forKey: kTTCardRepresentationBackImageKey];
    [encoder encodeBool: _isFaceUp forKey: kTTCardRepresentationIsFaceUpKey];
    [encoder encodeBool: _isTapped forKey: kTTCardRepresentationIsTappedKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTCardRepresentation *component = [super copyWithZone: zone];
    
    if (component) {
        component.frontImage = self.frontImage;
        component.backImage = self.backImage;
        
        if (component.isFaceUp != self.isFaceUp) {
            [component flip];
        }
        
        if (component.isTapped != self.isTapped) {
            [component tap];
        }
    }
    
    return component;
}

- (id) visibleImage {
    return self.isFaceUp ?
        self.frontImage : self.backImage;
}

- (void) flip {
    _isFaceUp = !_isFaceUp;
}

- (void) tap {
    _isTapped = !_isTapped;
}

/**
 A different card component is considered to be equal to the receiver only if both front- and back images are the same.
 */
- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTCardRepresentation *otherCardRepresentation = (TTCardRepresentation *)object;
        
        return
            [self.frontImage isEqualToString: otherCardRepresentation.frontImage] &&
            [self.backImage isEqualToString: otherCardRepresentation.backImage];
    }
    
    return NO;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"%@ %@%@", [super description], self.visibleImage, self.isTapped ? @" (tapped)" : @""];
}

@end
