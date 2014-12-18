//
//  TTAddComponentToEntityAction.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTAddComponentToEntityAction.h"

@implementation TTAddComponentToEntityAction

- (id) initWithComponents: (NSArray *) components toEntity: (TTEntity *) entity {
    if ((self = [super init])) {
        _entity = entity;
        _components = components;
    }

    return self;
}

- (BOOL) canExecute {
    if ([super canExecute]) {
        return self.entity && (self.components && self.components.count > 0);
    }

    return NO;
}

- (BOOL) execute {
    if ([super execute]) {
        if (self.entity && self.components) {
            return [self.entity addComponents:
                    self.components];
        }
    }

    return NO;
}

- (BOOL) undo {
    if ([super undo]) {
        if (self.entity && self.components) {
            return [self.entity removeComponents:
                    self.components];
        }
    }

    return NO;
}

- (NSString *) displayTitle {
    return @"Add component";
}

- (NSString *) displayInfo {
    return [NSString stringWithFormat:
            @"Added %lu %@",
            self.components.count,
            self.components.count > 1 ? @"components" : @"component"];
}

@end
