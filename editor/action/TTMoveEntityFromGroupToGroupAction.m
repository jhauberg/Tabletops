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

- (BOOL) canExecute {
    if ([super canExecute]) {
        return self.fromGroup && self.toGroup &&
            (self.entities && self.entities.count > 0);
    }

    return NO;
}

- (BOOL) execute {
    if ([super execute]) {
        return [self.toGroup moveEntities: self.entities
                                fromGroup: self.fromGroup];
    }

    return NO;
}

- (BOOL) undo {
    if ([super undo]) {
        return [self.fromGroup moveEntities: self.entities
                                  fromGroup: self.toGroup];
    }

    return NO;
}

- (NSString *) displayTitle {
    return self.entities.count > 1 ?
        @"Move entities" :
        @"Move entity";
}

- (NSString *) displayInfo {
    return [NSString stringWithFormat:
            @"Moved %lu %@",
            self.entities.count,
            self.entities.count > 1 ? @"entities" : @"1 entity"];
}

@end
