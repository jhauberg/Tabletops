//
//  TTEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTEntityComponent.h"

typedef BOOL (^TTEntityComponentConditional)(TTEntityComponent *component);

@interface TTEntity : NSObject <NSCoding, NSCopying>

+ (TTEntity *) entity;
+ (TTEntity *) entityWithComponents: (NSArray *) components;

@property (readonly) NSArray *components;

- (BOOL) addComponent: (TTEntityComponent *) component;
- (BOOL) removeComponent: (TTEntityComponent *) component;

- (id) getComponentOfType: (Class) type;
- (id) getComponentOfType: (Class) type matching: (TTEntityComponentConditional) condition;

- (NSArray *) getComponentsOfType: (Class) type;

- (id) getComponentLikeType: (Class) type;

- (id) getComponentLike: (TTEntityComponent *) otherComponent;
- (id) getComponentLike: (TTEntityComponent *) otherComponent matching: (TTEntityComponentConditional) condition;

- (BOOL) isLike: (TTEntity *) otherEntity;

@end
