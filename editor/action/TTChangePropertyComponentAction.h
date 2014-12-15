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

@property (nonatomic, readonly) TTPropertyComponent *propertyComponent;

@property (nonatomic, readonly) NSString *fromName;
@property (nonatomic, readonly) NSString *toName;

@property (nonatomic, readonly) id fromValue;
@property (nonatomic, readonly) id toValue;

/**
 Designated initializer.

 Create an action that changes the name and value of a property component.
 */
- (id) initWithNewName: (NSString *) newName andNewValue: (id) newValue forPropertyComponent: (TTPropertyComponent *) propertyComponent;

@end
