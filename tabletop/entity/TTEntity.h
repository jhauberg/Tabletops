//
//  TTEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

typedef BOOL (^TTEntityComponentConditional)(TTEntityComponent *component);

/**
 Represents an object on the tabletop.
 */
@interface TTEntity : NSObject <NSCoding, NSCopying>

/**
 Create a new entity.
 
 @returns A TTEntity object.
 */
+ (TTEntity *) entity;
/**
 Create a new entity with a set of initially added components.
 
 @returns A TTEntity object with components already added.
 */
+ (TTEntity *) entityWithComponents: (NSArray *) components;

@property (readonly) NSArray *components;

/**
 Add a component to the entity.
 
 @returns YES if the component was added, otherwise NO.
 */
- (BOOL) addComponent: (TTEntityComponent *) component;
/**
 Remove a component from the entity.
 
 @returns YES if the component was removed, otherwise NO.
 */
- (BOOL) removeComponent: (TTEntityComponent *) component;

/**
 Get a component of a given type.
 
 @returns A TTEntityComponent object that matches the specified type and is already added to the entity. Nil otherwise.
 */
- (id) getComponentOfType: (Class) type;
/**
 Get a component of a given type, that also matches a condition.
 
 @returns A TTEntityComponent object that matches the specified type, is already added to the entity, and matches the specified condition. Nil otherwise.
 */
- (id) getComponentOfType: (Class) type matching: (TTEntityComponentConditional) condition;

/**
 Get all components of a given type.
 
 @returns An NSArray of TTEntityComponent objects that matches the specified type and is already added to the entity. An empty NSArray otherwise.
 */
- (NSArray *) getComponentsOfType: (Class) type;

/**
 Get a component of a given type (or a subclass of).
 
 @returns A TTEntityComponent object that matches the specified type (or a subclass of) and is already added to the entity. Nil otherwise.
 */
- (id) getComponentLikeType: (Class) type;

/**
 Get a component that is similar to another component.
 
 @returns A TTEntityComponent object that is similar to otherComponent, if any. Nil otherwise.
 */
- (id) getComponentLike: (TTEntityComponent *) otherComponent;
/**
 Get a component that is similar to another component and matches a condition.
 
 @returns A TTEntityComponent object that is similar to otherComponent and matches the specified condition, if any. Nil otherwise.
 */
- (id) getComponentLike: (TTEntityComponent *) otherComponent matching: (TTEntityComponentConditional) condition;

/**
 Determine whether an entity is similar to the receiver.
 
 @returns YES if the otherEntity is similar, otherwise NO.
 */
- (BOOL) isLike: (TTEntity *) otherEntity;

@end
