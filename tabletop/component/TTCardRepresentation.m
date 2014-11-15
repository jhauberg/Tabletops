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
NSString* const kTTCardRepresentationIsFlippedKey = @"is_flipped";
NSString* const kTTCardRepresentationIsTappedKey = @"is_tapped";

@implementation TTCardRepresentation

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _frontImage = [decoder decodeObjectForKey: kTTCardRepresentationFrontImageKey];
        _backImage = [decoder decodeObjectForKey: kTTCardRepresentationBackImageKey];
        _isFlipped = [decoder decodeBoolForKey: kTTCardRepresentationIsFlippedKey];
        _isTapped = [decoder decodeBoolForKey: kTTCardRepresentationIsTappedKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _frontImage forKey: kTTCardRepresentationFrontImageKey];
    [encoder encodeObject: _backImage forKey: kTTCardRepresentationBackImageKey];
    [encoder encodeBool: _isFlipped forKey: kTTCardRepresentationIsFlippedKey];
    [encoder encodeBool: _isTapped forKey: kTTCardRepresentationIsTappedKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTCardRepresentation *component = [[[self class] allocWithZone: zone] init];
    
    if (component) {
        component.frontImage = self.frontImage;
        component.backImage = self.backImage;
        
        if (self.isFlipped) {
            [component flip];
        }
        
        if (self.isTapped) {
            [component tap];
        }
    }
    
    return component;
}

- (NSImage *) visibleImage {
    return self.isFlipped ?
        self.backImage : self.frontImage;
}

- (void) flip {
    _isFlipped = !_isFlipped;
}

- (void) tap {
    _isTapped = !_isTapped;
}

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTCardRepresentation *otherCardRepresentation = (TTCardRepresentation *)object;
        
        return
            [self.frontImage isEqual: otherCardRepresentation.frontImage] &&
            [self.backImage isEqual: otherCardRepresentation.backImage];
    }
    
    return NO;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"%@ %@%@", [super description], self.visibleImage, self.isTapped ? @" (tapped)" : @""];
}

@end
