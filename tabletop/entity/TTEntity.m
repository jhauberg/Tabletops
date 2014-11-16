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

+ (TTEntity *) entity {
    return [[TTEntity alloc] init];
}

+ (TTEntity *) entityWithComponents: (NSArray *) components {
    TTEntity *entity = [TTEntity entity];
    
    for (TTEntityComponent *component in components) {
        [entity addComponent:
         component];
    }
    
    return entity;
}

- (id) init {
    if ((self = [super init])) {
        _components = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super init])) {
        _components = [decoder decodeObjectForKey: kTTEntityComponentsKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: _components forKey: kTTEntityComponentsKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTEntity *entity = [[[self class] allocWithZone: zone] init];
    
    if (entity) {
        for (TTEntityComponent *component in _components) {
            [entity addComponent:
             [component copyWithZone: zone]];
        }
    }
    
    return entity;
}

- (NSArray *) components {
    return [NSArray arrayWithArray:
            _components];
}

- (BOOL) addComponent: (TTEntityComponent *) component {
    if ([_components containsObject: component]) {
        return NO;
    }
    
    [_components addObject: component];
    
    return YES;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (![_components containsObject: component]) {
        return NO;
    }
    
    [_components removeObject: component];
    
    return YES;
}

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
         @"\n  - %@", component];
    }
    
    return [NSString stringWithString:
            description];
}

@end
