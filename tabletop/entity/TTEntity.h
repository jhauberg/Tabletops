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
 Create a new entity with no components.
 
 @returns A TTEntity object.
 */
+ (instancetype) entity;
/**
 Create a new entity with a set of initially added components.
 
 @returns A TTEntity object with components already added.
 */
+ (instancetype) entityWithComponents: (NSArray *) components;

/**
 Get the components that are currently assigned to the entity.
 */
@property (readonly) NSArray *components;

/**
 Add a component to the entity.
 
 @returns YES if the component was added, otherwise NO.
 */
- (BOOL) addComponent: (TTEntityComponent *) component;
/**
 Add multiple components to the entity.
 
 @returns YES if the components were added, otherwise NO.
 */
- (BOOL) addComponents: (NSArray *) components;
/**
 Add multiple components to the entity.
 
 @returns YES if the components were added, otherwise NO. If specified as an atomic operation, only returns YES if *all* components were added.
 */
- (BOOL) addComponents: (NSArray *) components atomically: (BOOL) atomically;

/**
 Remove a component from the entity.
 
 @returns YES if the component was removed, otherwise NO.
 */
- (BOOL) removeComponent: (TTEntityComponent *) component;
/**
 Remove multiple components from the entity.
 
 @returns YES if the components were removed, otherwise NO.
 */
- (BOOL) removeComponents: (NSArray *) components;
/**
 Remove multiple components from the entity.
 
 @returns YES if the components were removed, otherwise NO. If specified as an atomic operation, only returns YES if *all* components were removed.
 */
- (BOOL) removeComponents: (NSArray *) components atomically: (BOOL) atomically;
/**
 Remove all components from the entity.
 
 @returns YES if all the components were removed, otherwise NO.
 */
- (BOOL) removeAllComponents;

/**
 Get a component of a given type.
 
 @returns The first TTEntityComponent object that matches the specified type and is already added to the entity. Nil otherwise.
 */
- (id) getComponentOfType: (Class) type;
/**
 Get a component of a given type, that also matches a condition.
 
 @returns The first TTEntityComponent object that matches the specified type, is already added to the entity, and matches the specified condition. Nil otherwise.
 */
- (id) getComponentOfType: (Class) type matching: (TTEntityComponentConditional) condition;

/**
 Get a component of a given type (or a subclass of).
 
 @returns The first TTEntityComponent object that matches the specified type (or a subclass of) and is already added to the entity. Nil otherwise.
 */
- (id) getComponentLikeType: (Class) type;

/**
 Get a component that is similar to another component.
 
 @returns The first TTEntityComponent object that is similar to otherComponent, if any. Nil otherwise.
 */
- (id) getComponentLike: (TTEntityComponent *) otherComponent;
/**
 Get a component that is similar to another component and matches a condition.
 
 @returns The first TTEntityComponent object that is similar to otherComponent and matches the specified condition, if any. Nil otherwise.
 */
- (id) getComponentLike: (TTEntityComponent *) otherComponent matching: (TTEntityComponentConditional) condition;

/**
 Get all components of a given type.

 @returns An NSArray of TTEntityComponent objects that matches the specified type and is already added to the entity. An empty NSArray otherwise.
 */
- (NSArray *) getComponentsOfType: (Class) type;

/**
 Get all components of a given type (or subclass of).

 @returns An NSArray of TTEntityComponent objects that matches the specified type (or a subclass of) and is already added to the entity. An empty NSArray otherwise.
 */
- (NSArray *) getComponentsLikeType: (Class) type;

/**
 Determine whether an entity is similar to the receiver.
 
 @returns YES if the otherEntity is similar, otherwise NO.
 */
- (BOOL) isLike: (TTEntity *) otherEntity;

@end
