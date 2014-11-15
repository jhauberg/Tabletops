//
//  TTRepresentationComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTRepresentationComponent.h"

NSString* const kTTRepresentationComponentPositionKey = @"position";

@implementation TTRepresentationComponent

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _position = [decoder decodePointForKey: kTTRepresentationComponentPositionKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodePoint: _position forKey: kTTRepresentationComponentPositionKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTRepresentationComponent *component = [[[self class] allocWithZone: zone] init];
    
    if (component) {
        component.position = self.position;
    }
    
    return component;
}

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTRepresentationComponent *otherRepresentationComponent = (TTRepresentationComponent *)object;
        
        return CGPointEqualToPoint(self.position,
                                   otherRepresentationComponent.position);
    }
    
    return NO;
}

@end
