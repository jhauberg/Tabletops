//
//  TTEntityGroupingComponent+Additions.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 13/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent+Additions.h"
#import "TTEntity.h"

#import "TTTagComponent.h"

@implementation TTEntityGroupingComponent (Additions)

- (id) getEntityWithTag: (NSString *) tag {
    id entity = nil;

    NSArray *entities = [self getEntitiesWithTag: tag];

    if (entities && [entities count] > 0) {
        entity = [entities firstObject];
    }

    return entity;
}

- (id) getEntityWithName: (NSString *) name {
    id entity = nil;

    NSArray *entities = [self getEntitiesWithName: name];

    if (entities && [entities count] > 0) {
        entity = [entities firstObject];
    }

    return entity;
}

- (NSArray *) getEntitiesWithName: (NSString *) name {
    return [self getEntitiesMatching:
            ^BOOL(TTEntity *entity) {
                if ([entity.name isEqualToString: name]) {
                    return YES;
                }

                return NO;
            }];
}

- (NSArray *) getEntitiesWithTag: (NSString *) tag {
    return [self getEntitiesMatching:
            ^BOOL(TTEntity *entity) {
                NSArray *tags = [entity getComponentsLikeType: [TTTagComponent class]];

                for (TTTagComponent *tagComponent in tags) {
                    if ([tagComponent.tag isEqualToString: tag]) {
                        return YES;
                    }
                }

                return NO;
            }];
}

@end
