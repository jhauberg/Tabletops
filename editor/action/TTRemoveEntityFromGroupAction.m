//
//  TTRemoveEntityFromGroupAction.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTRemoveEntityFromGroupAction.h"

@implementation TTRemoveEntityFromGroupAction

- (id) initWithEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) group {
    if ((self = [super init])) {
        _entities = entities;
        _group = group;
    }

    return self;
}

- (BOOL) canExecute {
    if ([super canExecute]) {
        return self.group && (self.entities && self.entities.count > 0);
    }

    return NO;
}

- (BOOL) execute {
    if ([super execute]) {
        if (self.entities && self.group) {
            return [self.group removeEntities:
                    self.entities];
        }
    }

    return NO;
}

- (BOOL) undo {
    if ([super undo]) {
        if (self.entities && self.group) {
            return [self.group addEntities:
                    self.entities];
        }
    }

    return NO;
}

- (NSString *) displayTitle {
    return self.entities.count > 1 ?
        @"Remove entities" :
        @"Remove entity";
}

- (NSString *) displayInfo {
    return [NSString stringWithFormat:
            @"Removed %lu %@",
            self.entities.count,
            self.entities.count > 1 ? @"entities" : @"1 entity"];
}

@end
