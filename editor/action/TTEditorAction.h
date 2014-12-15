//
//  TTEditorAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTEditableAction.h"

/**
 Base class for implementing editor actions.
 */
@interface TTEditorAction : NSObject <TTEditableAction>

/**
 Determine whether the action has been executed succesfully.
 */
@property (nonatomic, readonly) BOOL isExecuted;

/**
 Determine whether the action can be executed.
 */
@property (nonatomic, readonly) BOOL canExecute;
/**
 Determine whether the executed action can be undone.
 */
@property (nonatomic, readonly) BOOL canUndo;

@end
