//
//  TTEntity+Additions.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 30/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTEntity.h"
#import "TTPropertyComponent.h"
#import "TTTagComponent.h"

@interface TTEntity (Additions)

/**
 Create a new entity with a set of initially added property components.
 
 @returns A TTEntity object with property components already added.
 */
+ (nonnull instancetype) entityWithProperties: (nullable NSDictionary<NSString *, id<NSCoding, NSObject, NSCopying>> *) properties;
/**
 Create a new entity with a name and a set of initially added property components.
 
 @returns A TTEntity object with property components already added.
 */
+ (nonnull instancetype) entityWithName: (nullable NSString *) name
                          andProperties: (nullable NSDictionary<NSString *, id<NSCoding, NSObject, NSCopying>> *) properties;

/**
 Add multiple property components to the entity.
 
 @returns YES if all the property components were added, otherwise NO. Note that some of the properties may
          still have been added.
 */
- (BOOL) addProperties: (nullable NSDictionary<NSString *, id<NSCoding, NSObject, NSCopying>> *) properties;

/**
 Get all tags applied to the entity.
 
 @returns An NSArray of all TTTagComponent objects applied to the entity. An empty NSArray otherwise.
 */
- (nonnull NSArray<__kindof TTTagComponent *> *) getAllTags;

- (nullable TTTagComponent *) getTagWithName: (nonnull NSString *) tag;
- (nullable TTPropertyComponent *) getPropertyWithName: (nonnull NSString *) name;

/**
 Apply a tag to the entity.
 
 Does not apply the same tag twice.
 */
- (void) applyTagWithName: (nonnull NSString *) name;
/**
 Determine whether the entity has a specific tag applied to it.
 
 @returns YES if the entity has the tag applied to it, otherwise NO.
 */
- (BOOL) isTaggedWithName: (nonnull NSString *) name;
/**
 Determine whether the entity has a specific property assigned to it.
 
 @returns YES if the entity has the property assigned to it, otherwise NO.
 */
- (BOOL) hasPropertyWithName: (nonnull NSString *) name;

- (BOOL) moveComponent: (nonnull TTEntityComponent *) component fromEntity: (nonnull TTEntity *) entity;
- (BOOL) moveComponent: (nonnull TTEntityComponent *) component toEntity: (nonnull TTEntity *) entity;

@end
