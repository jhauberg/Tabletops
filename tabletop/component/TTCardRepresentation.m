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

+ (instancetype) representationWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside andBackside: (id<NSCoding, NSObject, NSCopying>) backside withFrontsideFacingUp: (BOOL) faceUp {
    return [[[self class] alloc] initWithFrontside: frontside
                                       andBackside: backside
                             withFrontsideFacingUp: faceUp];
}

- (instancetype) initWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside andBackside: (id<NSCoding, NSObject, NSCopying>) backside withFrontsideFacingUp: (BOOL) faceUp {
    if ((self = [super initWithFrontside: frontside andBackside: backside])) {
        if (faceUp) {
            [self flipToFrontside];
        }
    }

    return self;
}

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

- (BOOL) isFaceUp {
    return !self.isFlipped;
}

- (void) flip {
    [super flip];
}

- (void) flipRandomly {
    [super flipRandomly];
}

- (BOOL) flipToFrontside {
    return [super flipToFrontside];
}

- (BOOL) flipToBackside {
    return [super flipToBackside];
}

- (void) tap {
    _isTapped = !_isTapped;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"<%@: %p> Shows '%@'%@", self.class, self, self.visibleSide, self.isTapped ? @" (tapped)" : @""];
}

- (NSString *) shortDescription {
    return [NSString stringWithFormat:
            @"%@ (Shows '%@'%@)", self.class, self.visibleSide, self.isTapped ? @", tapped" : @""];
}

@end
