//
//  TTEntityGroupingComponent+Additions.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 13/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent.h"

@interface TTEntityGroupingComponent (Additions)

/**
 Get an entity tagged with the specified tag.
 
 @returns The first TTEntity object that has a matching tag. Nil if none was found.
 */
- (nullable id) getEntityWithTag: (nonnull NSString *) tag;
/**
 Get an entity with the specified name.
 
 @returns The first TTEntity object that has a matching name. Nil if none was found.
 */
- (nullable id) getEntityWithName: (nonnull NSString *) name;

/**
 Get all entities tagged with the specified tag.
 
 @returns An empty NSArray if none was found. Otherwise an NSArray containing all the matches.
 */
- (nonnull NSArray<__kindof TTEntity *> *) getEntitiesWithTag: (nonnull NSString *) tag;
/**
 Get all entities with the specified name.
 
 @returns An empty NSArray if none was found. Otherwise an NSArray containing all the matches.
 */
- (nonnull NSArray<__kindof TTEntity *> *) getEntitiesWithName: (nonnull NSString *) name;

@end
