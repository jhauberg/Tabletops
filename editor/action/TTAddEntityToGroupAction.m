//
//  TTAddEntityToGroupAction.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTAddEntityToGroupAction.h"

@implementation TTAddEntityToGroupAction

- (id) initWithEntities: (NSArray *) entities toGroup: (TTEntityGroupingComponent *) group {
    if ((self = [super init])) {
        _entities = entities;
        _group = group;
    }
    
    return self;
}

- (BOOL) execute {
    if ([super execute]) {
        if (self.entities && self.group) {
            return [self.group addEntities:
                    self.entities];
        }
    }
    
    return NO;
}

- (BOOL) undo {
    if ([super undo]) {
        if (self.entities && self.group) {
            return [self.group removeEntities:
                    self.entities];
        }
    }
    
    return NO;
}

@end