//
//  TTCloneEntityAction.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTCloneEntityAction.h"

@implementation TTCloneEntityAction

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
        if (!_clones) {
            NSMutableArray *clones = [[NSMutableArray alloc] init];
            
            for (TTEntity *entity in self.entities) {
                [clones addObject:
                 [entity copy]];
            }
            
            _clones = [NSArray arrayWithArray: clones];
        }

        return [self.group addEntities:
                self.clones];
    }
    
    return NO;
}

- (BOOL) undo {
    if ([super undo]) {
        return [self.group removeEntities:
                self.clones];
    }
    
    return NO;
}

- (NSString *) displayTitle {
    return self.entities.count > 1 ?
        @"Clone entities" :
        @"Clone entity";
}

- (NSString *) displayInfo {
    return [NSString stringWithFormat:
            @"Cloned %lu %@",
            self.entities.count,
            self.entities.count > 1 ? @"entities" : @"entity"];
}

@end

