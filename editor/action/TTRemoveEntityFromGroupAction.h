//
//  TTRemoveEntityFromGroupAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorAction.h"

#import "TTEntity.h"
#import "TTEntityGroupingComponent.h"

/**
 Provides an action for removing an entity (or more) from a group.
 */
@interface TTRemoveEntityFromGroupAction : TTEditorAction

@property (nonatomic, readonly) NSArray *entities;

@property (nonatomic, readonly) TTEntityGroupingComponent *group;

/**
 Designated initializer.

 Create an action that removes entities from a group.
 */
- (id) initWithEntities: (NSArray *) entities fromGroup: (TTEntityGroupingComponent *) group;

@end
