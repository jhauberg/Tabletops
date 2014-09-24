//
//  TTDieRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDieRepresentation.h"

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
    if ((self = [super init])) {
        _sides = [decoder decodeObjectForKey: @"sides"];
        _sideImages = [decoder decodeObjectForKey: @"side_images"];
        _upside = [_sides firstObject];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: _sides forKey: @"sides"];
    [encoder encodeObject: _sideImages forKey: @"side_images"];
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
                NSLog(@"too few sideImages");
            } else if ([sideImages count] > self.sides.count) {
                NSLog(@"too many sideImages. sides.count = %lu", self.sides.count);
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
    
    return result;
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
