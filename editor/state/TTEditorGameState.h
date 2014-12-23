//
//  TTEditorGameState.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 17/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTGameState.h"

#import "TTAction.h"
#import "TTEditorAction.h"

/**
 Provides do/undo/redo functionality for state altering actions.
 */
@interface TTEditorGameState : TTGameState

/**
 All executed actions including those that have been undone.
 
 Note that all undone actions will be removed once a new action is executed.
 */
@property (nonatomic, readonly) NSArray *actions;
/**
 All executed actions except those that have been undone.
 */
@property (nonatomic, readonly) NSArray *executedActions;

/**
 Execute an undoable action.

 If the action has been previously undone, then this will redo the action and all undone actions prior to this one, starting with the oldest action first.

 If the action is a new one, then this will clear all actions that have previously been undone.
 */
- (BOOL) executeAction: (TTEditorAction *) action;
/**
 Undo an executed action.
 
 If this is not the most recent action, then all actions that were executed after this one will also be undone.
 */
- (BOOL) undoAction: (TTEditorAction *) action;

@end
