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

@end
