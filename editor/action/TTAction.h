//
//  TTAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 19/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorAction.h"

typedef BOOL (^TTActionBlock)();

/**
 Provides an editor action for block-based executable actions.
 */
@interface TTAction : TTEditorAction

+ (TTAction *) action: (TTActionBlock) action undo: (TTActionBlock) undoAction;
+ (TTAction *) actionTitled: (NSString *) title action: (TTActionBlock) action undo: (TTActionBlock) undoAction;
+ (TTAction *) actionTitled: (NSString *) title withInfo: (NSString *) info action: (TTActionBlock) action undo: (TTActionBlock) undoAction;

/**
 The block that is executed when doing/redoing the action.
 */
@property (readonly) TTActionBlock action;
/**
 The block that is performed when undoing the executed action.
 */
@property (readonly) TTActionBlock undoAction;

/**
 Designated initializer.
 
 Create an action with an optional title and info, along with executable do/undo block actions.
 */
- (instancetype) initWithTitle: (NSString *) title andInfo: (NSString *) info action: (TTActionBlock) action undo: (TTActionBlock) undoAction;

@end
