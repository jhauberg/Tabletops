//
//  TTEntityGroupingComponent+Additions.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 13/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent.h"

@interface TTEntityGroupingComponent (Additions)

- (nullable id) getEntityWithTag: (nonnull NSString *) tag;
- (nullable id) getEntityWithName: (nonnull NSString *) name;

- (nonnull NSArray<__kindof TTEntity *> *) getEntitiesWithTag: (nonnull NSString *) tag;
- (nonnull NSArray<__kindof TTEntity *> *) getEntitiesWithName: (nonnull NSString *) name;

@end
