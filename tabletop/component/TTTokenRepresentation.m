//
//  TTTokenRepresentation.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTokenRepresentation.h"

NSString* const kTTTokenRepresentationFrontsideKey = @"frontside";

@implementation TTTokenRepresentation

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _frontside = [decoder decodeObjectForKey: kTTTokenRepresentationFrontsideKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _frontside forKey: kTTTokenRepresentationFrontsideKey];
}

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTTokenRepresentation *otherTokenRepresentation = (TTTokenRepresentation *)object;
        
        return [otherTokenRepresentation.frontside isEqual:
                self.frontside];
    }
    
    return NO;
}

@end
