//
//  TTEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"

NSString* const kTTEntityComponentsKey = @"components";

@implementation TTEntity {
 @private
    NSMutableArray *_components;
}

#pragma mark Convenience

+ (instancetype) entity {
    return [[[self class] alloc] init];
}

+ (instancetype) entityWithComponents: (NSArray *) components {
    return [[[self class] alloc] initWithComponents: components];
}

#pragma mark Initialization

- (instancetype) init {
    if ((self = [super init])) {
        if (!_components) {
            _components = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

- (instancetype) initWithComponents: (NSArray *) components {
    if ((self = [self init])) {
        [self addComponents: components];
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [self init])) {
        if (_components) {
            [_components addObjectsFromArray:
             [decoder decodeObjectForKey: kTTEntityComponentsKey]];
        }
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: _components forKey: kTTEntityComponentsKey];
}

- (id) copyWithZone: (NSZone *) zone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:
            [NSKeyedArchiver archivedDataWithRootObject:
             self]];
}

#pragma mark Component

- (NSArray *) components {
    return [NSArray arrayWithArray:
            _components];
}

- (BOOL) addComponent: (TTEntityComponent *) component {
    if ([_components containsObject: component]) {
        return NO;
    }
    
#ifdef DEBUG
    for (TTEntityComponent *existingComponent in _components) {
        if ([existingComponent isLike: component]) {
            NSLog(@" *** Adding '%@' to an entity which already has a similar component. Are you sure this is intended? ↲%@", component, self);
            
            break;
        }
    }
#endif
    
    [_components addObject: component];
    
    return YES;
}

- (BOOL) addComponents: (NSArray *) components {
    return [self addComponents: components
                    atomically: YES];
}

- (BOOL) addComponents: (NSArray *) components atomically: (BOOL) atomically {
    NSMutableArray *addedComponents = atomically ? [[NSMutableArray alloc] init] : nil;
    
    for (TTEntityComponent *component in components) {
        if ([self addComponent: component] && atomically) {
            [addedComponents addObject: component];
        } else {
            if (atomically) {
                [self removeComponents:
                 addedComponents];
            }
            
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (![_components containsObject: component]) {
        return NO;
    }
    
    [_components removeObject: component];
    
    return YES;
}

- (BOOL) removeComponents: (NSArray *) components {
    return [self removeComponents: components
                       atomically: YES];
}

- (BOOL) removeComponents: (NSArray *) components atomically: (BOOL) atomically {
    NSMutableArray *removedComponents = atomically ? [[NSMutableArray alloc] init] : nil;
    
    for (TTEntityComponent *component in components) {
        if ([self removeComponent: component] && atomically) {
            [removedComponents addObject: component];
        } else {
            if (atomically) {
                [self addComponents:
                 removedComponents];
            }
            
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) removeAllComponents {
    return [self removeComponents: _components
                       atomically: YES];
}

#pragma mark Component Query

- (id) getComponentOfType: (Class) type {
    return [self getComponentOfType: type
                           matching: nil];
}

- (id) getComponentOfType: (Class) type matching: (TTEntityComponentConditional) condition {
    for (TTEntityComponent *component in _components) {
        if (component.class == type) {
            if (!condition || (condition && condition(component))) {
                return component;
            }
        }
    }
    
    return nil;
}

- (id) getComponentLikeType: (Class) type {
    for (TTEntityComponent *component in _components) {
        if ([component isKindOfClass: type]) {
            return component;
        }
    }
    
    return nil;
}

- (id) getComponentLike: (TTEntityComponent *) otherComponent {
    return [self getComponentLike: otherComponent
                         matching: nil];
}

- (id) getComponentLike: (TTEntityComponent *) otherComponent matching: (TTEntityComponentConditional) condition {
    for (TTEntityComponent *component in _components) {
        if ([component isLike: otherComponent]) {
            if (!condition || (condition && condition(component))) {
                return component;
            }
        }
    }
    
    return nil;
}

- (NSArray *) getComponentsOfType: (Class) type {
    NSMutableArray *components = [[NSMutableArray alloc] init];

    for (TTEntityComponent *component in _components) {
        if (component.class == type) {
            [components addObject:
             component];
        }
    }

    return [NSArray arrayWithArray:
            components];
}

- (NSArray *) getComponentsLikeType: (Class) type {
    NSMutableArray *components = [[NSMutableArray alloc] init];

    for (TTEntityComponent *component in _components) {
        if ([component isKindOfClass: type]) {
            [components addObject:
             component];
        }
    }

    return [NSArray arrayWithArray:
            components];
}

#pragma mark Other

/**
 Determines similarity, or 'like'-ness, by whether the entity has the same types of components with the same values.
 */
- (BOOL) isLike: (TTEntity *) otherEntity {
    if ([otherEntity isKindOfClass: [self class]]) {
        // Note the checking of equality against each component, and NOT whether they're 'like' each other.
        // An entity is ONLY like another entity if all components are equal; an entity is NEVER equal to another entity.
        // Imagine two cards of the same type; they are treated the same, but they are still two cards.
        return [self.components isEqualToArray:
                otherEntity.components];
    }
    
    return NO;
}

- (NSString *) description {
    NSMutableString *description = [[NSMutableString alloc] initWithString:
                                    [NSString stringWithFormat: @"\n %@", [super description]]];
    
    for (TTEntityComponent *component in _components) {
        [description appendFormat:
         @"\n  ↳ %@", component];
    }
    
    return [NSString stringWithString:
            description];
}

- (NSString *) shortDescription {
    NSMutableString *componentsDescription = [[NSMutableString alloc] init];

    for (TTEntityComponent *component in _components) {
        if ([componentsDescription length] > 0) {
            [componentsDescription appendString: @", "];
        } else {
            [componentsDescription appendString: @" "];
        }

        [componentsDescription appendFormat: @"%@", [component shortDescription]];
    }

    return [NSString stringWithFormat:
            @"<%@: %p>%@", [self className], self, componentsDescription];
}

@end
