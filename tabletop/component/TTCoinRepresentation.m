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

+ (instancetype) representationWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside
                                 andBackside: (id<NSCoding, NSObject, NSCopying>) backside {
    return [[[self class] alloc] initWithFrontside: frontside
                                       andBackside: backside];
}

- (instancetype) init {
    if ((self = [super init])) {
        _isFlipped = NO;
    }

    return self;
}

- (instancetype) initWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside
                       andBackside: (id<NSCoding, NSObject, NSCopying>) backside {
    if ((self = [super initWithFrontside: frontside])) {
        _backside = backside;
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

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTCoinRepresentation *otherCoinRepresentation = (TTCoinRepresentation *)object;

        return [otherCoinRepresentation.backside isEqual:
                self.backside];
    }

    return NO;
}

- (id<NSCoding, NSObject, NSCopying>) visibleSide {
    return self.isFlipped ?
        self.backside : self.frontside;
}

- (void) flip {
    _isFlipped = !_isFlipped;
}

- (void) flipRandomly {
    _isFlipped = arc4random_uniform((u_int32_t)2) == 1;
}

- (BOOL) flipToFrontside {
    if (_isFlipped) {
        [self flip];
        
        return YES;
    }
    
    return NO;
}

- (BOOL) flipToBackside {
    if (!_isFlipped) {
        [self flip];
        
        return YES;
    }
    
    return NO;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"<%@: %p> Shows '%@'", self.class, self, self.visibleSide];
}

- (NSString *) shortDescription {
    return [NSString stringWithFormat:
            @"%@ (Shows '%@')", self.class, self.visibleSide];
}

@end
