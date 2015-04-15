//
//  TTMoveEntityFromGroupToGroupAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorAction.h"

#import "TTEntity.h"
#import "TTEntityGroupingComponent.h"

/**
 Provides an action for moving a grouped entity (or more) to another group.
 */
@interface TTMoveEntityFromGroupToGroupAction : TTEditorAction

@property (readonly) NSArray *entities;

@property (readonly) TTEntityGroupingComponent *fromGroup;
@property (readonly) TTEntityGroupingComponent *toGroup;

/**
 Designated initializer.

 Create an action that moves entities from a group to another group.
 */
- (instancetype) initWithEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) fromGroup toGroup: (TTEntityGroupingComponent *) toGroup;

@end
