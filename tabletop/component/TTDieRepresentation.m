//
//  TTDieRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDieRepresentation.h"

NSString* const kTTDieRepresentationSidesKey = @"sides";
NSString* const kTTDieRepresentationUpsideKey = @"upside";

@implementation TTDieRepresentation

@synthesize upside = _upside;

- (instancetype) initWithSides: (NSArray *) sides {
    if ((self = [super init])) {
        _sides = sides;
        _upside = [sides firstObject];
    }

    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _sides = [decoder decodeObjectForKey: kTTDieRepresentationSidesKey];
        _upside = [decoder decodeObjectForKey: kTTDieRepresentationUpsideKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _sides forKey: kTTDieRepresentationSidesKey];
    [encoder encodeObject: _upside forKey: kTTDieRepresentationUpsideKey];
}

- (id<NSObject, NSCoding, NSCopying>) upside {
    return _upside;
}

- (void) setUpside: (id<NSObject, NSCopying, NSCoding>) upside {
    if (![self.sides containsObject: upside]) {
        [NSException raise: @"Invalid side"
                    format: @"Must be a side on the die"];
        
        return;
    }
    
    _upside = upside;
}

- (id) roll {
    id result = nil;
    
    if (self.sides) {
        result = self.sides[arc4random_uniform((uint32_t)self.sides.count)];
    }
    
    _upside = result;
    
    return _upside;
}

/**
 A different die component is considered to be equal to the receiver only if all sides, side images and
 current side facing up are all the same.
 */
- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTDieRepresentation *otherDieRepresentation = (TTDieRepresentation *)object;
        
        return
            [self.sides isEqualToArray: otherDieRepresentation.sides] &&
            [self.upside isEqual: otherDieRepresentation.upside];
    }
    
    return NO;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"%@ %@", [super description], self.sides];
}

@end
