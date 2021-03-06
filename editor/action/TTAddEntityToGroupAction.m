//
//  TTAddEntityToGroupAction.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTAddEntityToGroupAction.h"

@implementation TTAddEntityToGroupAction

- (instancetype) initWithEntities: (NSArray *) entities toGroup: (TTEntityGroupingComponent *) group {
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
        return [self.group addEntities:
                self.entities];
    }
    
    return NO;
}

- (BOOL) undo {
    if ([super undo]) {
        return [self.group removeEntities:
                self.entities];
    }
    
    return NO;
}

- (NSString *) displayTitle {
    return self.entities.count > 1 ?
        @"Add entities" :
        @"Add entity";
}

- (NSString *) displayInfo {
    return [NSString stringWithFormat:
            @"Added %lu %@",
            self.entities.count,
            self.entities.count > 1 ? @"entities" : @"entity"];
}

@end
