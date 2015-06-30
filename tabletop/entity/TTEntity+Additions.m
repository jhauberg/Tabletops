//
//  TTEntity+Additions.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 30/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity+Additions.h"

@implementation TTEntity (Additions)

- (NSArray *) getAllTags {
    return [self getComponentsLikeType:
            [TTTagComponent class]];
}

- (TTTagComponent *) getTagWithName: (NSString *) tag {
    return [self getComponentLikeType: [TTTagComponent class]
                             matching: ^BOOL(TTEntityComponent *component) {
                                 return [((TTTagComponent *)component).tag isEqualToString: tag];
                             }];
}

- (TTPropertyComponent *) getPropertyWithName: (NSString *) name {
    return [self getComponentLikeType: [TTPropertyComponent class]
                             matching: ^BOOL(TTEntityComponent *component) {
                                 return [((TTPropertyComponent *)component).name isEqualToString: name];
                             }];
}

- (BOOL) isTaggedWithName: (NSString *) name {
    return [self getTagWithName: name] != nil;
}

- (BOOL) hasPropertyWithName: (nonnull NSString *) name {
    return [self getPropertyWithName: name] != nil;
}

- (BOOL) moveComponent: (TTEntityComponent *) component fromEntity: (TTEntity *) entity {
    return [entity moveComponent: component
                        toEntity: self];
}

- (BOOL) moveComponent: (TTEntityComponent *) component toEntity: (TTEntity *) entity {
    if ([self removeComponent: component]) {
        if ([entity addComponent: component]) {
            return YES;
        }
    }

    return NO;
}

@end
