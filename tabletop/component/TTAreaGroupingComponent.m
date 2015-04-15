//
//  TTAreaGroupingComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 29/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTAreaGroupingComponent.h"
#import "TTRepresentationComponent.h"

NSString* const kTTAreaGroupingComponentAreaKey = @"area";

@implementation TTAreaGroupingComponent

- (instancetype) init {
    if (((self = [super init]))) {
        self.area = CGRectZero;
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        self.area = [decoder decodeRectForKey: kTTAreaGroupingComponentAreaKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeRect: _area forKey: kTTAreaGroupingComponentAreaKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTAreaGroupingComponent *component = [super copyWithZone: zone];
    
    if (component) {
        component.area = self.area;
    }
    
    return component;
}

- (BOOL) addEntity: (TTEntity *) entity {
    if ([self canAddEntity: entity]) {
        return [super addEntity: entity];
    }
    
    return NO;
}

- (BOOL) canAddEntity: (TTEntity *) entity {
    TTRepresentationComponent *representation = [entity getComponentLikeType:
                                                 [TTRepresentationComponent class]];
    
    if (representation) {
        return CGRectContainsPoint(self.area, representation.position);
    }
    
    return NO;
}

@end
