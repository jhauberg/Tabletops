//
//  TTCardRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTCardRepresentation.h"

NSString* const kTTCardRepresentationIsTappedKey = @"is_tapped";

@implementation TTCardRepresentation

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _isTapped = [decoder decodeBoolForKey: kTTCardRepresentationIsTappedKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];

    [encoder encodeBool: _isTapped forKey: kTTCardRepresentationIsTappedKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTCardRepresentation *component = [super copyWithZone: zone];
    
    if (component) {
        if (component.isTapped != self.isTapped) {
            [component tap];
        }
    }
    
    return component;
}

- (BOOL) isFaceUp {
    return !self.isFlipped;
}

- (id<NSCoding, NSObject, NSCopying>) visibleSide {
    return self.isFaceUp ?
        self.frontside : self.backside;
}

- (void) flip {
    [super flip];
}

- (void) flip: (BOOL) randomly {
    [super flip: randomly];
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
            [self.frontside isEqual: otherCardRepresentation.frontside] &&
            [self.backside isEqual: otherCardRepresentation.backside];
    }
    
    return NO;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"%@ %@%@", [super description], self.visibleSide, self.isTapped ? @" (tapped)" : @""];
}

@end
