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

+ (instancetype) representationWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside {
    TTTokenRepresentation *representation = [[[self class] alloc] init];

    if (representation) {
        representation.frontside = frontside;
    }

    return representation;
}

- (instancetype) initWithFrontside: (id<NSCoding, NSObject, NSCopying>) frontside {
    if ((self = [self init])) {
        _frontside = frontside;
    }

    return self;
}

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

- (NSString *) description {
    return [NSString stringWithFormat:
            @"<%@: %p> Shows '%@'", self.class, self, self.frontside];
}

- (NSString *) shortDescription {
    return [NSString stringWithFormat:
            @"%@ (Shows '%@')", self.class, self.frontside];
}

@end
