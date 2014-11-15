//
//  TTDieRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDieRepresentation.h"

NSString* const kTTDieRepresentationSidesKey = @"sides";
NSString* const kTTDieRepresentationSideImagesKey = @"side_images";

@implementation TTDieRepresentation

@synthesize sideImages = _sideImages;

- (id) initWithSides: (NSArray *) sides {
    if ((self = [super init])) {
        _sides = sides;
        _upside = [sides firstObject];
    }

    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _sides = [decoder decodeObjectForKey: kTTDieRepresentationSidesKey];
        _sideImages = [decoder decodeObjectForKey: kTTDieRepresentationSideImagesKey];
        _upside = [_sides firstObject];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _sides forKey: kTTDieRepresentationSidesKey];
    [encoder encodeObject: _sideImages forKey: kTTDieRepresentationSideImagesKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTDieRepresentation *component = [[[self class] allocWithZone: zone] initWithSides: self.sides];
    
    if (component) {
        component.sideImages = self.sideImages;
    }
    
    return component;
}

- (NSArray *) sideImages {
    return _sideImages;
}

- (void) setSideImages: (NSArray *) sideImages {
    if (self.sides) {
        if (sideImages) {
            if ([sideImages count] < self.sides.count) {
                [NSException raise: @"Too few side images specified"
                            format: @"Must specify %lu images", self.sides.count];
            } else if ([sideImages count] > self.sides.count) {
                [NSException raise: @"Too many side images specified"
                            format: @"Must specify %lu images", self.sides.count];
            } else {
                _sideImages = sideImages;
            }
        }
    }
}

- (id) roll {
    id result = nil;
    
    if (self.sides) {
        result = [self.sides objectAtIndex:
                  rand() % self.sides.count];
    }
    
    _upside = result;
    
    return self.upside;
}

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTDieRepresentation *otherDieRepresentation = (TTDieRepresentation *)object;
        
        return
            [self.sides isEqualToArray: otherDieRepresentation.sides] &&
            [self.sideImages isEqualToArray: otherDieRepresentation.sideImages];
    }
    
    return NO;
}

- (NSString *) description {
    NSMutableArray *sidesAndImages = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < [self.sides count]; i++) {
        id side = [self.sides objectAtIndex: i];
        id sideImage = [self.sideImages objectAtIndex: i];
        
        [sidesAndImages addObject:
         [NSString stringWithFormat:
          @"%@ (%@)", side, sideImage]];
    }
    
    return [NSString stringWithFormat:
            @"%@ %@", [super description], sidesAndImages];
}

@end
