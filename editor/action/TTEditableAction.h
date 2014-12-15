//
//  TTEditableAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

/**
 Defines an executable action that can be undone.
 */
@protocol TTEditableAction <NSObject>

@required

/**
 Execute an undoable action.
 
 @returns YES if the action was executed successfully, NO otherwise.
 */
- (BOOL) execute;
/**
 Undo the executed action.
 
 @returns YES if the action was undone successfully, NO otherwise.
 */
- (BOOL) undo;

@end
