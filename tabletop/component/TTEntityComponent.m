//
//  TTEntityComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

@implementation TTEntityComponent

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super init])) {

    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    
}

- (id) copyWithZone: (NSZone *) zone {
    return [[[self class] allocWithZone: zone] init];
}

- (BOOL) isEqual: (id) object {
    return [object isKindOfClass:
            [self class]];
}

- (BOOL) isLike: (TTEntityComponent *) otherComponent {
    return [otherComponent isKindOfClass:
            [self class]];
}

@end
