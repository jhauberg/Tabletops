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

@property (nonatomic, readonly) TTEntity *entity;

@property (nonatomic, readonly) NSArray *components;

/**
 Designated initializer.

 Create an action that adds components to an entity.
 */
- (id) initWithComponents: (NSArray *) components toEntity: (TTEntity *) entity;

@end
