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

@property (nonatomic, readonly) NSArray *entities;
@property (nonatomic, readonly) NSArray *clones;

@property (nonatomic, readonly) TTEntityGroupingComponent *group;

/**
 Designated initializer.
 
 Create an action that clones entities and adds them to a group.
 */
- (id) initWithEntities: (NSArray *) entities toGroup: (TTEntityGroupingComponent *) group;

@end
