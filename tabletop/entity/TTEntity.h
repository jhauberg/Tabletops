//
//  TTEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

typedef BOOL (^TTEntityComponentConditional)(TTEntityComponent * __nonnull component);

/**
 Represents an object on the tabletop.
 */
@interface TTEntity : NSObject <NSCoding, NSCopying>

/**
 Create a new entity.
 
 @returns A TTEntity object.
 */
+ (nonnull instancetype) entity;
/**
 Create a new entity with a set of initially added components.

 @returns A TTEntity object with components already added.
 */
+ (nonnull instancetype) entityWithComponents: (nullable NSArray<__kindof TTEntityComponent *> *) components;
/**
 Create a new entity with a name.

 @returns A TTEntity object.
 */
+ (nonnull instancetype) entityWithName: (nullable NSString *) name;
/**
 Create a new entity with a name and a set of initially added components.

 @returns A TTEntity object with components already added.
 */
+ (nonnull instancetype) entityWithName: (nullable NSString *) name
                          andComponents: (nullable NSArray<__kindof TTEntityComponent *> *) components;

/**
 Get the components that are currently assigned to the entity.
 */
@property (nonnull, readonly) NSArray<__kindof TTEntityComponent *> *components;

/**
 Get or set the name for this entity.
 
 A name can be used to easily identify an entity.
 */
@property (nullable, strong) NSString *name;

/**
 Create a new entity with no components.
 
 @returns A TTEntity object.
 */
- (nonnull instancetype) init NS_DESIGNATED_INITIALIZER;
/**
 Create a new entity with a set of initially added components.
 
 @returns A TTEntity object with components already added.
 */
- (nonnull instancetype) initWithComponents: (nullable NSArray<__kindof TTEntityComponent *> *) components;

/**
 Add a component to the entity.
 
 @returns YES if the component was added, otherwise NO.
 */
- (BOOL) addComponent: (nonnull TTEntityComponent *) component;
/**
 Add multiple components to the entity.
 
 @returns YES if the components were added, otherwise NO.
 */
- (BOOL) addComponents: (nonnull NSArray<__kindof TTEntityComponent *> *) components;
/**
 Add multiple components to the entity.
 
 @returns YES if the components were added, otherwise NO. If specified as an atomic operation, 
          only returns YES if *all* components were added.
 */
- (BOOL) addComponents: (nonnull NSArray<__kindof TTEntityComponent *> *) components
            atomically: (BOOL) atomically;

/**
 Remove a component from the entity.
 
 @returns YES if the component was removed, otherwise NO.
 */
- (BOOL) removeComponent: (nonnull TTEntityComponent *) component;
/**
 Remove multiple components from the entity.
 
 @returns YES if the components were removed, otherwise NO.
 */
- (BOOL) removeComponents: (nonnull NSArray<__kindof TTEntityComponent *> *) components;
/**
 Remove multiple components from the entity.
 
 @returns YES if the components were removed, otherwise NO. If specified as an atomic operation, only returns YES
          if *all* components were removed.
 */
- (BOOL) removeComponents: (nonnull NSArray<__kindof TTEntityComponent *> *) components
               atomically: (BOOL) atomically;
/**
 Remove all components from the entity.
 
 @returns YES if all the components were removed, otherwise NO.
 */
- (BOOL) removeAllComponents;

/**
 Get a component of a given type.
 
 @returns The first TTEntityComponent object that matches the specified type and is already added to the entity.
          Nil otherwise.
 */
- (nullable id) getComponentOfType: (nonnull Class) type;
/**
 Get a component of a given type, that also matches a condition.
 
 @returns The first TTEntityComponent object that matches the specified type, is already added to the entity, and
          matches the specified condition. Nil otherwise.
 */
- (nullable id) getComponentOfType: (nonnull Class) type
                          matching: (nullable TTEntityComponentConditional) condition;

/**
 Get a component of a given type (or a subclass of).
 
 @returns The first TTEntityComponent object that matches the specified type (or a subclass of) and is already added
          to the entity. Nil otherwise.
 */
- (nullable id) getComponentLikeType: (nonnull Class) type;
/**
 Get a component of a given type (or a subclass of), that also matches a condition.
 
 @returns The first TTEntityComponent object that matches the specified type (or a subclass of), is already added to 
          the entity, and matches the specified condition. Nil otherwise.
 */
- (nullable id) getComponentLikeType: (nonnull Class) type
                            matching: (nullable TTEntityComponentConditional) condition;

/**
 Get a component that is similar to another component.
 
 @returns The first TTEntityComponent object that is similar to otherComponent, if any. Nil otherwise.
 */
- (nullable id) getComponentLike: (nonnull TTEntityComponent *) otherComponent;
/**
 Get a component that is similar to another component and matches a condition.
 
 @returns The first TTEntityComponent object that is similar to otherComponent and matches the specified condition,
          if any. Nil otherwise.
 */
- (nullable id) getComponentLike: (nonnull TTEntityComponent *) otherComponent
                        matching: (nullable TTEntityComponentConditional) condition;

/**
 Get all components of a given type.

 @returns An NSArray of TTEntityComponent objects that matches the specified type and is already added to the entity.
          An empty NSArray otherwise.
 */
- (nonnull NSArray<__kindof TTEntityComponent *> *) getComponentsOfType: (nonnull Class) type;

/**
 Get all components of a given type (or subclass of).

 @returns An NSArray of TTEntityComponent objects that matches the specified type (or a subclass of) and is already 
          added to the entity. An empty NSArray otherwise.
 */
- (nonnull NSArray<__kindof TTEntityComponent *> *) getComponentsLikeType: (nonnull Class) type;

/**
 Determine whether an entity is similar to the receiver.
 
 @returns YES if the otherEntity is similar, otherwise NO.
 */
- (BOOL) isLike: (nonnull TTEntity *) otherEntity;

/**
 Get a short description of this entity instance.
 
 This is similar to calling @c description, but will result in a one-line description.
 */
- (nonnull NSString *) shortDescription;

@end
