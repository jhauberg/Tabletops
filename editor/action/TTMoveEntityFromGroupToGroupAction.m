//
//  TTMoveEntityFromGroupToGroupAction.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTMoveEntityFromGroupToGroupAction.h"

@implementation TTMoveEntityFromGroupToGroupAction

- (id) initWithEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) fromGroup toGroup: (TTEntityGroupingComponent *) toGroup {
    if ((self = [super init])) {
        _entities = entities;
        _fromGroup = fromGroup;
        _toGroup = toGroup;
    }

    return self;
}

- (BOOL) execute {
    if ([super execute]) {
        if (self.entities && self.toGroup) {
            return [self.toGroup moveEntities: self.entities
                                    fromGroup: self.fromGroup];
        }
    }

    return NO;
}

- (BOOL) undo {
    if ([super undo]) {
        if (self.entities && self.fromGroup) {
            return [self.fromGroup moveEntities: self.entities
                                      fromGroup: self.toGroup];
        }
    }

    return NO;
}

@end
