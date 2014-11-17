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
        for (TTEntity *groupedEntity in self.entities) {
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
    for (TTEntity *entity in entities) {
        if (![self addEntity: entity]) {
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

- (BOOL) moveEntity: (TTEntity *) entity fromGrouping: (TTEntityGroupingComponent *) grouping {
    return [self moveEntity: entity
               fromGrouping: grouping
                 atomically: YES];
}

- (BOOL) moveEntity: (TTEntity *) entity fromGrouping: (TTEntityGroupingComponent *) grouping atomically: (BOOL) atomically {
    BOOL didAddEntity = [self addEntity: entity];
    
    if (didAddEntity) {
        BOOL didRemoveEntity = [grouping removeEntity: entity];
        
        if (didRemoveEntity) {
            return YES;
        }
        
        if (atomically) {
            [self removeEntity: entity];
        }
    }
    
    return NO;
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
        
        return [self.entities isEqualToArray:
                otherGroupingComponent.entities];
    }
    
    return NO;
}

- (NSString *) description {
    NSMutableArray *shortEntityDescriptions = [[NSMutableArray alloc] init];
    
    for (TTEntity *entity in self.entities) {
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
