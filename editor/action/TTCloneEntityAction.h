//
//  TTCloneEntityAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorAction.h"

#import "TTEntity.h"
#import "TTEntityGroupingComponent.h"

/**
 Provides an action for cloning an entity (or more) and adding to a group.
 */
@interface TTCloneEntityAction : TTEditorAction

@property (readonly) NSArray *entities;
@property (readonly) NSArray *clones;

@property (readonly) TTEntityGroupingComponent *group;

/**
 Designated initializer.
 
 Create an action that clones entities and adds them to a group.
 */
- (instancetype) initWithEntities: (NSArray *) entities toGroup: (TTEntityGroupingComponent *) group;

@end
