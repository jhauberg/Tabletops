//
//  TTEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "Tabletops.h"

#import "TTEntity.h"

NSString* const kTTEntityComponentsKey = @"components";
NSString* const kTTEntityNameKey = @"name";

@implementation TTEntity {
 @private
    NSMutableArray<__kindof TTEntityComponent *> *_components;
}

#pragma mark Convenience

+ (instancetype) entity {
    return [[[self class] alloc] init];
}

+ (instancetype) entityWithComponents: (NSArray<__kindof TTEntityComponent *> *) components {
    return [[[self class] alloc] initWithComponents: components];
}

+ (instancetype) entityWithName: (NSString *) name {
    return [self entityWithName: name
                 andComponents: nil];
}

+ (instancetype) entityWithName: (NSString *) name andComponents: (NSArray<__kindof TTEntityComponent *> *) components {
    TTEntity *entity = [self entityWithComponents: components];

    if (entity) {
        entity.name = name;
    }

    return entity;
}

#pragma mark Initialization

- (instancetype) init {
    if ((self = [super init])) {
        if (!_components) {
            _components = [[NSMutableArray<__kindof TTEntityComponent *> alloc] init];
        }
    }
    
    return self;
}

- (instancetype) initWithComponents: (NSArray<__kindof TTEntityComponent *> *) components {
    if ((self = [self init])) {
        [self addComponents: components];
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [self init])) {
        _name = [decoder decodeObjectForKey: kTTEntityNameKey];

        if (_components) {
            [_components addObjectsFromArray:
             [decoder decodeObjectForKey: kTTEntityComponentsKey]];
        }
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: _name forKey: kTTEntityNameKey];
    [encoder encodeObject: _components forKey: kTTEntityComponentsKey];
}

- (id) copyWithZone: (NSZone *) zone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:
            [NSKeyedArchiver archivedDataWithRootObject:
             self]];
}

#pragma mark Component

- (NSArray<__kindof TTEntityComponent *> *) components {
    return [NSArray arrayWithArray:
            _components];
}

- (BOOL) addComponent: (TTEntityComponent *) component {
    if (!component) {
        return NO;
    }
    
    if ([_components containsObject: component]) {
        TTDebugWarning(@"Attempted to add '%@' to '<%@: %p>%@' which already had this component assigned."
                       @"The component was not added.",
                       component, self.class, self, [self nameOrNothing]);

        return NO;
    }
    
#ifdef DEBUG
    for (TTEntityComponent *existingComponent in _components) {
        if ([existingComponent isLike: component]) {
            TTDebugWarning(@"Adding '%@' to '<%@: %p>%@' which already has a similar component ('%@') assigned."
                           @"The component was added anyway. Are you sure this was intended?",
                           component, self.class, self, [self nameOrNothing], existingComponent);
            
            break;
        }
    }
#endif
    
    [_components addObject: component];
        
    return YES;
}

- (BOOL) addComponents: (NSArray<__kindof TTEntityComponent *> *) components {
    return [self addComponents: components
                    atomically: YES];
}

- (BOOL) addComponents: (NSArray<__kindof TTEntityComponent *> *) components atomically: (BOOL) atomically {
    NSMutableArray<__kindof TTEntityComponent *> *addedComponents = atomically ? [[NSMutableArray alloc] init] : nil;
    
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
    if (!component) {
        return NO;
    }
    
    if (![_components containsObject: component]) {
        TTDebugWarning(@"Attempted to remove '%@' from '<%@: %p>%@' which did not have this component assigned."
                       @"The component was not removed.",
                       component, self.class, self, [self nameOrNothing]);

        return NO;
    }
    
    [_components removeObject: component];
    
    return YES;
}

- (BOOL) removeComponents: (NSArray<__kindof TTEntityComponent *> *) components {
    return [self removeComponents: components
                       atomically: YES];
}

- (BOOL) removeComponents: (NSArray<__kindof TTEntityComponent *> *) components atomically: (BOOL) atomically {
    NSMutableArray<__kindof TTEntityComponent *> *removedComponents = atomically ? [[NSMutableArray alloc] init] : nil;
    
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
    return [self getComponentLikeType: type
                             matching: nil];
}

- (id) getComponentLikeType: (Class) type matching: (TTEntityComponentConditional) condition {
    for (TTEntityComponent *component in _components) {
        if ([component isKindOfClass: type]) {
            if (!condition || (condition && condition(component))) {
                return component;
            }
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

- (NSArray<__kindof TTEntityComponent *> *) getComponentsOfType: (Class) type {
    NSMutableArray<__kindof TTEntityComponent *> *components = [[NSMutableArray alloc] init];

    for (TTEntityComponent *component in _components) {
        if (component.class == type) {
            [components addObject:
             component];
        }
    }

    return [NSArray arrayWithArray:
            components];
}

- (NSArray<__kindof TTEntityComponent *> *) getComponentsLikeType: (Class) type {
    NSMutableArray<__kindof TTEntityComponent *> *components = [[NSMutableArray alloc] init];

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
 Determines equality by comparing likeness and @c name.
 
 Two entities are considered equal if they have the same name, and if they both have the same amount of components
 assigned and all of those components are alike.
 */
- (BOOL) isEqual: (id) object {
    if ([self isLike: object]) {
        TTEntity *otherEntity = (TTEntity *)object;

        if (self.name && otherEntity.name) {
            return [otherEntity.name compare: self.name] == NSOrderedSame;
        }
    }

    return NO;
}

/**
 Determines similarity, or likeness, by whether the entity has the same types of components with the same values.
 */
- (BOOL) isLike: (TTEntity *) otherEntity {
    if ([otherEntity isKindOfClass: [self class]]) {
        NSArray<__kindof TTEntityComponent *> *otherComponents = otherEntity.components;

        if (_components.count == otherComponents.count) {
            for (NSUInteger i = 0; i < otherComponents.count; i++) {
                TTEntityComponent *component = _components[i];
                TTEntityComponent *otherComponent = otherComponents[i];

                if (![component isEqual: otherComponent]) {
                    return NO;
                }
            }
            
            return YES;
        }
    }
    
    return NO;
}

- (NSArray *) componentsSortedAlphabetically {
    return [_components sortedArrayUsingComparator:
            ^NSComparisonResult(TTEntityComponent *lhs, TTEntityComponent *rhs) {
                return [NSStringFromClass([lhs class]) compare:
                        NSStringFromClass([rhs class])];
            }];
}

- (NSString *) nameOrNothing {
    return self.name ? [NSString stringWithFormat: @" \"%@\"", self.name] : @"";
}

- (NSString *) description {
    NSMutableString *description = [[NSMutableString alloc] initWithString:
                                    [NSString stringWithFormat: @"\n <%@%@: %p>",
                                     self.class, [self nameOrNothing], self]];
    
    for (TTEntityComponent *component in [self componentsSortedAlphabetically]) {
        [description appendFormat:
         @"\n  ↳ %@", component];
    }
    
    return [NSString stringWithString:
            description];
}

- (NSString *) shortDescription {
    NSMutableString *componentsDescription = [[NSMutableString alloc] init];

    for (TTEntityComponent *component in [self componentsSortedAlphabetically]) {
        if ([componentsDescription length] > 0) {
            [componentsDescription appendString: @", "];
        } else {
            [componentsDescription appendString: @" "];
        }

        [componentsDescription appendFormat: @"%@", [component shortDescription]];
    }

    return [NSString stringWithFormat:
            @"<%@%@: %p>%@", NSStringFromClass([self class]), [self nameOrNothing], self, componentsDescription];
}

@end
