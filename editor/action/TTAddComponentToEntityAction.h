//
//  TTAddComponentToEntityAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorAction.h"

#import "TTEntity.h"

/**
 Provides an action for adding a component (or more) to an entity.
 */
@interface TTAddComponentToEntityAction : TTEditorAction

@property (readonly) TTEntity *entity;

@property (readonly) NSArray *components;

/**
 Designated initializer.

 Create an action that adds components to an entity.
 */
- (instancetype) initWithComponents: (NSArray *) components toEntity: (TTEntity *) entity;

@end
