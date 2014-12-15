//
//  TTEntityGroupingComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTEntityGroupingComponent.h"

NSString* const kTTEntityGroupingComponentEntitiesKey = @"entities";

@implementation TTEntityGroupingComponent

- (id) init {
    if (((self = [super init]))) {
        if (!_entities) {
            _entities = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _entities = [decoder decodeObjectForKey: kTTEntityGroupingComponentEntitiesKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _entities forKey: kTTEntityGroupingComponentEntitiesKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTEntityGroupingComponent *component = [[[self class] allocWithZone: zone] init];
    
    if (component) {
        for (TTEntity *groupedEntity in _entities) {
            [component addEntity:
             [groupedEntity copyWithZone: zone]];
        }
    }
    
    return component;
}

- (NSArray *) entities {
    return [NSArray arrayWithArray:
            _entities];
}

- (BOOL) addEntity: (TTEntity *) entity {
    if ([_entities containsObject: entity]) {
        return NO;
    }
    
    [_entities addObject: entity];
    
    return YES;
}

- (BOOL) addEntities: (NSArray *) entities {
    return [self addEntities: entities
                  atomically: YES];
}

- (BOOL) addEntities: (NSArray *) entities atomically: (BOOL) atomically {
    NSMutableArray *addedEntities = atomically ? [[NSMutableArray alloc] init] : nil;
    
    for (TTEntity *entity in entities) {
        if ([self addEntity: entity] && atomically) {
            [addedEntities addObject: entity];
        } else {
            if (atomically) {
                [self removeEntities:
                 addedEntities];
            }
            
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) removeEntity: (TTEntity *) entity {
    if (![_entities containsObject: entity]) {
        return NO;
    }

    [_entities removeObject: entity];
    
    return YES;
}

- (BOOL) removeEntities: (NSArray *) entities {
    return [self removeEntities: entities
                     atomically: YES];
}

- (BOOL) removeEntities: (NSArray *) entities atomically: (BOOL) atomically {
    NSMutableArray *removedEntities = atomically ? [[NSMutableArray alloc] init] : nil;
    
    for (TTEntity *entity in entities) {
        if ([self removeEntity: entity] && atomically) {
            [removedEntities addObject: entity];
        } else {
            if (atomically) {
                [self addEntities:
                 removedEntities];
            }
            
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) removeAllEntities {
    return [self removeEntities: _entities
                     atomically: YES];
}

- (BOOL) moveEntity: (TTEntity *) entity fromGroup: (TTEntityGroupingComponent *) group {
    return [self moveEntity: entity
                  fromGroup: group
                 atomically: YES];
}

- (BOOL) moveEntity: (TTEntity *) entity fromGroup: (TTEntityGroupingComponent *) group atomically: (BOOL) atomically {
    if (group != self) {
        BOOL didAddEntity = [self addEntity: entity];
        
        if (didAddEntity) {
            BOOL didRemoveEntity = [group removeEntity: entity];
            
            if (didRemoveEntity) {
                return YES;
            }
            
            if (atomically) {
                [self removeEntity: entity];
            }
        }
    }
    
    return NO;
}

- (BOOL) moveEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) group {
    return [self moveEntities: entities
                    fromGroup: group
                   atomically: YES];
}

- (BOOL) moveEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) group atomically: (BOOL) atomically {
    for (TTEntity *entity in entities) {
        if (![self moveEntity: entity
                    fromGroup: group
                   atomically: atomically]) {
            if (atomically) {
                return NO;
            }
        }
    }

    return YES;
}

- (NSArray *) getEntitiesMatching: (TTEntityConditional) condition {
    return [self getEntitiesMatching: condition
                    inChildGroupings: YES];
}

- (NSArray *) getEntitiesMatching: (TTEntityConditional) condition inChildGroupings: (BOOL) searchDeeper {
    NSMutableArray *entities = [[NSMutableArray alloc] init];

    for (TTEntity *entity in _entities) {
        if (condition && condition(entity)) {
            if (![entities containsObject: entity]) {
                [entities addObject: entity];
            }
        }

        if (searchDeeper) {
            NSArray *groupings = [entity getComponentsLikeType:
                                  [TTEntityGroupingComponent class]];

            for (TTEntityGroupingComponent *grouping in groupings) {
                if (grouping != self) {
                    [entities addObjectsFromArray:
                     [grouping getEntitiesMatching: condition]];
                }
            }
        }
    }

    return [NSArray arrayWithArray:
            entities];
}

/**
 Sorts entities by 'like'-ness.
 
 The comparison considers two different entities to be the same only if they are 'like' each other,
 otherwise it bases the comparison on the amount of components they have.
 */
- (void) sort {
    [_entities sortUsingComparator: ^NSComparisonResult(id left, id right) {
        TTEntity *entity = (TTEntity *)left;
        TTEntity *otherEntity = (TTEntity *)right;
        
        if (entity && otherEntity) {
            if ([entity isLike: otherEntity]) {
                return NSOrderedSame;
            } else if (entity.components.count > otherEntity.components.count) {
                return NSOrderedDescending;
            }
        }
        
        return NSOrderedAscending;
    }];
}

- (void) sort: (NSComparator) comparison {
    [_entities sortUsingComparator: comparison];
}

- (void) sortBy: (TTPropertyComponent *) propertyComponent {
    [self sortByComponents:
     @[ propertyComponent ]];
}

- (void) sortByComponents: (NSArray *) propertyComponents {
    [_entities sortUsingComparator: ^NSComparisonResult(id left, id right) {
        for (TTPropertyComponent *propertyComponent in propertyComponents) {
            TTEntity *entity = (TTEntity *)left;
            TTEntity *otherEntity = (TTEntity *)right;
            
            TTPropertyComponent *property = [entity getComponentLike: propertyComponent];
            TTPropertyComponent *otherProperty = [otherEntity getComponentLike: propertyComponent];
            
            if (property && otherProperty) {
                NSInteger comparison = [property compare:
                                        otherProperty];
                
                if (comparison != NSOrderedSame) {
                    return comparison;
                }
            }
        }
        
        return NSOrderedSame;
    }];
}

- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        TTEntityGroupingComponent *otherGroupingComponent = (TTEntityGroupingComponent *)object;
        
        return [_entities isEqualToArray:
                otherGroupingComponent.entities];
    }
    
    return NO;
}

- (NSString *) description {
    NSMutableArray *shortEntityDescriptions = [[NSMutableArray alloc] init];
    
    for (TTEntity *entity in _entities) {
        NSMutableString *componentsDescription = [[NSMutableString alloc] init];
        
        for (TTEntityComponent *component in entity.components) {
            if ([componentsDescription length] > 0) {
                [componentsDescription appendString: @", "];
            }
            
            [componentsDescription appendFormat: @"%@", component.class];
        }
        
        [shortEntityDescriptions addObject:
         [NSString stringWithFormat: @"<%@: %p> %@", [entity className], entity, componentsDescription]];
    }
    
    return [NSString stringWithFormat:
            @"%@ %@", [super description], shortEntityDescriptions];
}

@end
