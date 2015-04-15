//
//  TTAddEntityToGroupAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorAction.h"

#import "TTEntity.h"
#import "TTEntityGroupingComponent.h"

/**
 Provides an action for adding an entity (or more) to a group.
 */
@interface TTAddEntityToGroupAction : TTEditorAction

@property (readonly) NSArray *entities;

@property (readonly) TTEntityGroupingComponent *group;

/**
 Designated initializer.
 
 Create an action that adds entities to a group.
 */
- (instancetype) initWithEntities: (NSArray *) entities toGroup: (TTEntityGroupingComponent *) group;

@end
