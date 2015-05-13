//
//  TTEntityGroupingComponent+Additions.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 13/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent+Additions.h"
#import "TTEntity.h"

@implementation TTEntityGroupingComponent (Additions)

- (NSArray *) getEntitiesWithTag: (NSString *) tag {
    return [self getEntitiesMatching:
            ^BOOL(TTEntity *entity) {
                return [entity.tag isEqualToString: tag];
            }];
}

@end
