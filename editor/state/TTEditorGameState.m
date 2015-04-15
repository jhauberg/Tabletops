//
//  TTEditorGameState.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 17/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorGameState.h"

@implementation TTEditorGameState {
 @private
    NSMutableArray *_executedActions;
    TTEditorAction *_mostRecentlyUndoneAction;
}

- (instancetype) init {
    if ((self = [super init])) {
        _executedActions = [[NSMutableArray alloc] init];
    }

    return self;
}

- (BOOL) executeAction: (TTEditorAction *) action {
    if ([_executedActions containsObject: action]) {
        if (action.isExecuted) {
            return NO;
        }

        if (_mostRecentlyUndoneAction) {
            return [self redoAction:
                    action];
        }
    }

    if (_mostRecentlyUndoneAction) {
        // clear all undone actions that were executed after the most recently undone action
        NSInteger indexOfAction = [_executedActions indexOfObject:
                                   _mostRecentlyUndoneAction];
        
        if (indexOfAction != NSNotFound) {
            [_executedActions removeObjectsInRange:
             NSMakeRange(indexOfAction, _executedActions.count - indexOfAction)];
            
            _mostRecentlyUndoneAction = nil;
        }
    }

    if (![action execute]) {
        return NO;
    }

    [_executedActions addObject: action];

    return YES;
}

- (BOOL) undoAction: (TTEditorAction *) action {
    if (![_executedActions containsObject: action]) {
        return NO;
    }

    NSUInteger i = _executedActions.count - 1;

    TTEditorAction *previouslyDoneAction = nil;

    // undo every action that happened after the specified action to undo
    while (![(previouslyDoneAction = _executedActions[i--]) isEqual: action]) {
        if (![self undoAction: previouslyDoneAction]) {
            break;
        }
    }

    if (![action undo]) {
        return NO;
    }

    _mostRecentlyUndoneAction = action;

    return YES;
}

- (BOOL) redoAction: (TTEditorAction *) action {
    NSInteger i = [_executedActions indexOfObject:
                   _mostRecentlyUndoneAction];

    TTEditorAction *previouslyUndoneAction = nil;

    // execute every action that were undone prior to the specified action to redo
    while (![(previouslyUndoneAction = _executedActions[i++]) isEqual: action]) {
        if (![previouslyUndoneAction execute]) {
            break;
        }

        _mostRecentlyUndoneAction = previouslyUndoneAction;
    }

    if (![action execute]) {
        return NO;
    }

    if ([_executedActions count] > i) {
        _mostRecentlyUndoneAction = _executedActions[i];
    } else {
        _mostRecentlyUndoneAction = nil;
    }

    return YES;
}

- (NSArray *) actions {
    return [NSArray arrayWithArray:
            _executedActions];
}

- (NSArray *) executedActions {
    if (_mostRecentlyUndoneAction) {
        return [_executedActions subarrayWithRange:
                NSMakeRange(0, [_executedActions indexOfObject:
                                _mostRecentlyUndoneAction])];
    }
    
    return self.actions;
}

@end
