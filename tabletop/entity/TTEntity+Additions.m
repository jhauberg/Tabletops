//
//  TTEntity+Additions.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 30/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity+Additions.h"

@implementation TTEntity (Additions)

- (TTPropertyComponent *) getPropertyComponentWithName: (NSString *) name {
    return [self getComponentOfType: [TTPropertyComponent class]
                           matching: ^BOOL(TTEntityComponent *component) {
                               return [((TTPropertyComponent *)component).name isEqualToString: name];
                           }];
}

@end
