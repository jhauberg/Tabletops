//
//  TTTokenRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTokenRepresentation.h"

NSString* const kTTTokenRepresentationImageKey = @"image";

@implementation TTTokenRepresentation

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _image = [decoder decodeObjectForKey: kTTTokenRepresentationImageKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _image forKey: kTTTokenRepresentationImageKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTTokenRepresentation *component = [[[self class] allocWithZone: zone] init];
    
    if (component) {
        component.image = self.image;
    }
    
    return component;
}

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTTokenRepresentation *otherTokenRepresentation = (TTTokenRepresentation *)object;
        
        return [self.image isEqualToString:
                otherTokenRepresentation.image];
    }
    
    return NO;
}

@end
