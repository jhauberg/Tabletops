//
//  TTEntityGroupingComponent+Additions.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 13/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent.h"

@interface TTEntityGroupingComponent (Additions)

- (id) getEntityWithTag: (NSString *) tag;
- (id) getEntityWithName: (NSString *) name;

- (NSArray *) getEntitiesWithTag: (NSString *) tag;
- (NSArray *) getEntitiesWithName: (NSString *) name;

@end
