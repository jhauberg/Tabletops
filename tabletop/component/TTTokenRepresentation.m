//
//  TTTokenRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTokenRepresentation.h"

NSString* const kTTTokenRepresentationFrontImageKey = @"front_image";

@implementation TTTokenRepresentation

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _frontImage = [decoder decodeObjectForKey: kTTTokenRepresentationFrontImageKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _frontImage forKey: kTTTokenRepresentationFrontImageKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTTokenRepresentation *component = [super copyWithZone: zone];
    
    if (component) {
        component.frontImage = self.frontImage;
    }
    
    return component;
}

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTTokenRepresentation *otherTokenRepresentation = (TTTokenRepresentation *)object;
        
        return [self.frontImage isEqualToString:
                otherTokenRepresentation.frontImage];
    }
    
    return NO;
}

@end
