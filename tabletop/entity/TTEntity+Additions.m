//
//  TTEntity+Additions.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 30/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity+Additions.h"

@implementation TTEntity (Additions)

- (TTPropertyComponent *) getPropertyWithName: (NSString *) name {
    return [self getComponentLikeType: [TTPropertyComponent class]
                             matching: ^BOOL(TTEntityComponent *component) {
                                 return [((TTPropertyComponent *)component).name isEqualToString: name];
                             }];
}

- (TTTagComponent *) getTagNamed: (NSString *) tag {
    return [self getComponentLikeType: [TTTagComponent class]
                             matching: ^BOOL(TTEntityComponent *component) {
                                 return [((TTTagComponent *)component).tag isEqualToString: tag];
                             }];
}

- (NSArray *) getTags {
    return [self getComponentsLikeType:
            [TTTagComponent class]];
}

@end
