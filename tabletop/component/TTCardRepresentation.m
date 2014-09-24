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

@implementation TTCardRepresentation

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super init])) {
        _frontImage = [decoder decodeObjectForKey: kTTCardRepresentationFrontImageKey];
        _backImage = [decoder decodeObjectForKey: kTTCardRepresentationBackImageKey];
        _isFlipped = [decoder decodeBoolForKey: kTTCardRepresentationIsFlippedKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: _frontImage forKey: kTTCardRepresentationFrontImageKey];
    [encoder encodeObject: _backImage forKey: kTTCardRepresentationBackImageKey];
    [encoder encodeBool: _isFlipped forKey: kTTCardRepresentationIsFlippedKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTCardRepresentation *component = [[[self class] allocWithZone: zone] init];
    
    if (component) {
        component.frontImage = self.frontImage;
        component.backImage = self.backImage;
        
        if (self.isFlipped) {
            [component flip];
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
            @"%@ %@%@", [super description], self.visibleImage, self.isFlipped ? @" (flipped)" : @""];
}

@end
