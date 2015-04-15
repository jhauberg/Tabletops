//
//  TTChangePropertyComponentAction.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEditorAction.h"

#import "TTPropertyComponent.h"

/**
 Provides an action for changing the name and value of a property component.
 */
@interface TTChangePropertyComponentAction : TTEditorAction

@property (readonly) TTPropertyComponent *propertyComponent;

@property (readonly) NSString *fromName;
@property (readonly) NSString *toName;

@property (readonly) id fromValue;
@property (readonly) id toValue;

/**
 Designated initializer.

 Create an action that changes the name and value of a property component.
 */
- (instancetype) initWithNewName: (NSString *) newName andNewValue: (id) newValue forPropertyComponent: (TTPropertyComponent *) propertyComponent;

@end
