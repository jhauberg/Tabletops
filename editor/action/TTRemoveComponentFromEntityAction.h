//
//  TTRemoveComponentFromEntityAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorAction.h"

#import "TTEntity.h"

/**
 Provides an action for removing a component (or more) from an entity.
 */
@interface TTRemoveComponentFromEntityAction : TTEditorAction

@property (readonly) TTEntity *entity;

@property (readonly) NSArray *components;

/**
 Designated initializer.

 Create an action that removes components from an entity.
 */
- (instancetype) initWithComponents: (NSArray *) components fromEntity: (TTEntity *) entity;

@end
