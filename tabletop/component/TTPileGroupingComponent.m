//
//  TTPileGroupingComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 01/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTPileGroupingComponent.h"

@implementation TTPileGroupingComponent

- (TTEntity *) draw {
    TTEntity *entity = nil;

    if (_entities.count > 0) {
        NSUInteger index = arc4random_uniform((uint32_t)_entities.count);

        entity = _entities[index];

        [_entities removeObjectAtIndex: index];
    }

    return entity;
}

- (NSArray *) draw: (NSUInteger) amount {
    NSMutableArray *entities = [[NSMutableArray alloc] init];

    for (NSUInteger i = 0; i < amount; i++) {
        TTEntity *entity = [self draw];

        if (!entity) {
            break;
        }

        [entities addObject:
         entity];
    }

    return [NSArray arrayWithArray:
            entities];
}

@end
