//
//  TTEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTEntityComponent.h"

typedef BOOL (^TTEntityConditional)(TTEntityComponent *component);

@interface TTEntity : NSObject <NSCoding, NSCopying>

@property (readonly) NSArray *components;

- (BOOL) addComponent: (TTEntityComponent *) component;
- (BOOL) removeComponent: (TTEntityComponent *) component;

- (id) getComponentOfType: (Class) type;
- (id) getComponentOfType: (Class) type matching: (TTEntityConditional) condition;

- (NSArray *) getComponentsOfType: (Class) type;

- (id) getComponentLike: (TTEntityComponent *) otherComponent;
- (id) getComponentLike: (TTEntityComponent *) otherComponent matching: (TTEntityConditional) condition;

- (BOOL) isLike: (TTEntity *) otherEntity;

@end
