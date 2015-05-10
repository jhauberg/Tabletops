//
//  TTEntityComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

@implementation TTEntityComponent

- (instancetype) initWithCoder: (NSCoder *) decoder {
    return [self init];
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    // nothing to encode
}

- (id) copyWithZone: (NSZone *) zone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:
            [NSKeyedArchiver archivedDataWithRootObject:
             self]];
}

- (BOOL) isEqual: (id) object {
    // override to determine equality based on other/more factors
    return [object isKindOfClass:
            [self class]];
}

- (BOOL) isLike: (TTEntityComponent *) otherComponent {
    // override to determine likeness based on other/more factors
    return [otherComponent isKindOfClass:
            [self class]];
}

@end
