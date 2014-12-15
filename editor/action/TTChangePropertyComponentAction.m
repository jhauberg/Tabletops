//
//  TTChangePropertyComponentAction.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/12/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTChangePropertyComponentAction.h"

@implementation TTChangePropertyComponentAction

- (id) initWithNewName: (NSString *) newName andNewValue: (id) newValue forPropertyComponent: (TTPropertyComponent *) propertyComponent {
    if ((self = [super init])) {
        _propertyComponent = propertyComponent;

        if (_propertyComponent) {
            _fromName = _propertyComponent.name;
            _fromValue = _propertyComponent.value;
        }

        _toName = newName;
        _toValue = newValue;
    }

    return self;
}

- (BOOL) execute {
    if ([super execute]) {
        if (self.propertyComponent) {
            BOOL hasNameChange = self.propertyComponent.name != self.toName;
            BOOL hasValueChange = self.propertyComponent.value != self.toValue;

            if (hasNameChange || hasValueChange) {
                if (hasNameChange) {
                    self.propertyComponent.name = self.toName;
                }

                if (hasValueChange) {
                    self.propertyComponent.value = self.toValue;
                }

                return YES;
            }
        }
    }

    return NO;
}

- (BOOL) undo {
    if ([super undo]) {
        if (self.propertyComponent) {
            BOOL hasNameChange = self.propertyComponent.name != self.fromName;
            BOOL hasValueChange = self.propertyComponent.value != self.fromValue;

            if (hasNameChange || hasValueChange) {
                if (hasNameChange) {
                    self.propertyComponent.name = self.fromName;
                }

                if (hasValueChange) {
                    self.propertyComponent.value = self.fromValue;
                }

                return YES;
            }
        }
    }

    return NO;
}

@end
