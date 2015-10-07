//
//  TTEntity+Additions.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 30/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity+Additions.h"

@implementation TTEntity (Additions)

+ (nonnull instancetype) entityWithProperties: (nullable NSDictionary *) properties {
    TTEntity *entity = [self entity];
    
    if (entity) {
        [entity addProperties: properties];
    }
    
    return entity;
}

+ (nonnull instancetype) entityWithName: (nullable NSString *) name andProperties: (nullable NSDictionary<NSString *, id<NSCoding, NSObject, NSCopying>> *) properties {
    TTEntity *entity = [self entityWithProperties: properties];
    
    if (entity) {
        entity.name = name;
    }
    
    return entity;
}

- (BOOL) addProperties: (nullable NSDictionary<NSString *, id<NSCoding, NSObject, NSCopying>> *) properties {
    BOOL didAddAllProperties = YES;
    
    if (properties) {
        for (NSString *key in [properties allKeys]) {
            TTPropertyComponent *property = [TTPropertyComponent propertyWithName: key
                                                                         andValue: properties[key]];
            
            if (![self addComponent: property]) {
                didAddAllProperties = NO;
            }
        }
    }
    
    return didAddAllProperties;
}

- (NSArray<__kindof TTTagComponent *> *) getAllTags {
    return [self getComponentsLikeType:
            [TTTagComponent class]];
}

- (void) applyTagWithName: (nonnull NSString *) name {
    [self addComponent:
     [TTTagComponent componentWithTag: name]];
}

- (TTTagComponent *) getTagWithName: (NSString *) tag {
    return [self getComponentLikeType: [TTTagComponent class]
                             matching: ^BOOL(TTEntityComponent *component) {
                                 return [((TTTagComponent *)component).tag isEqualToString: tag];
                             }];
}

- (TTPropertyComponent *) getPropertyWithName: (NSString *) name {
    return [self getComponentLikeType: [TTPropertyComponent class]
                             matching: ^BOOL(TTEntityComponent *component) {
                                 return [((TTPropertyComponent *)component).name isEqualToString: name];
                             }];
}

- (BOOL) isTaggedWithName: (NSString *) name {
    return [self getTagWithName: name] != nil;
}

- (BOOL) hasPropertyWithName: (nonnull NSString *) name {
    return [self getPropertyWithName: name] != nil;
}

- (BOOL) moveComponent: (TTEntityComponent *) component fromEntity: (TTEntity *) entity {
    return [entity moveComponent: component
                        toEntity: self];
}

- (BOOL) moveComponent: (TTEntityComponent *) component toEntity: (TTEntity *) entity {
    if ([self removeComponent: component]) {
        if ([entity addComponent: component]) {
            return YES;
        }
    }

    return NO;
}

@end
