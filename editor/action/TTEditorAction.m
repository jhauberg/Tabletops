//
//  TTEditorAction.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorAction.h"

@implementation TTEditorAction

- (id) init {
    if ((self = [super init])) {
        _isExecuted = NO;
    }
    
    return self;
}

- (BOOL) canExecute {
    return !self.isExecuted;
}

- (BOOL) canUndo {
    return self.isExecuted;
}

- (BOOL) execute {
    if (self.canExecute) {
        _isExecuted = YES;
        
        return YES;
    }
    
    return NO;
}

- (BOOL) undo {
    if (self.canUndo) {
        _isExecuted = NO;
        
        return YES;
    }
    
    return NO;
}

- (NSString *) displayTitle {
    return @"No title";
}

- (NSString *) displayInfo {
    return nil;
}

- (NSString *) description {
    NSString *description = nil;
    
    if (self.displayInfo) {
        description = [NSString stringWithFormat:
                       @"%@: %@", self.displayTitle, self.displayInfo];
    } else {
        description = self.displayTitle;
    }
    
    return description;
}

@end
