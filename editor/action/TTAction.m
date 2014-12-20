//
//  TTAction.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 19/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTAction.h"

@implementation TTAction {
 @private
    NSString *_title;
    NSString *_info;
}

+ (TTAction *) action: (TTActionBlock) action undo: (TTActionBlock) undoAction {
    return [self actionTitled: nil
                     withInfo: nil
                       action: action
                         undo: undoAction];
}

+ (TTAction *) actionTitled: (NSString *) title action: (TTActionBlock) action undo: (TTActionBlock) undoAction {
    return [self actionTitled: title
                     withInfo: nil
                       action: action
                         undo: undoAction];
}

+ (TTAction *) actionTitled: (NSString *) title withInfo: (NSString *) info action: (TTActionBlock) action undo: (TTActionBlock) undoAction {
    return [[TTAction alloc] initWithTitle: title
                                   andInfo: info
                                    action: action
                                      undo: undoAction];
}

- (id) initWithTitle: (NSString *) title andInfo: (NSString *) info action: (TTActionBlock) action undo: (TTActionBlock) undoAction {
    if ((self = [super init])) {
        _title = title;
        _info = info;
        _action = action;
        _undoAction = undoAction;
    }
    
    return self;
}

- (BOOL) canExecute {
    if ([super canExecute]) {
        return self.action && self.undoAction;
    }
    
    return NO;
}

- (BOOL) execute {
    if ([super execute]) {
        return self.action();
    }
    
    return NO;
}

- (BOOL) undo {
    if ([super undo]) {
        return self.undoAction();
    }
    
    return NO;
}

- (BOOL) isEqual: (id) object {
    if (self == object) {
        return YES;
    }
    
    if ([object isKindOfClass: [TTAction class]]) {
        TTAction *otherAction = (TTAction *)object;
        
        if (self.action == otherAction.action &&
            self.undoAction == otherAction.undoAction) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *) displayTitle {
    return _title ? _title : [super displayTitle];
}

- (NSString *) displayInfo {
    return _info ? _info : [super displayInfo];
}

@end
