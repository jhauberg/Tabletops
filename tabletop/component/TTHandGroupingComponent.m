//
//  TTHandGroupingComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 22/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTHandGroupingComponent.h"

NSString* const kTTHandGroupingComponentOwnerKey = @"owner";

@implementation TTHandGroupingComponent

- (id) initWithOwner: (TTEntity *) owner {
    if ((self = [super init])) {
        self.owner = owner;
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        self.owner = [decoder decodeObjectForKey: kTTHandGroupingComponentOwnerKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _owner forKey: kTTHandGroupingComponentOwnerKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTHandGroupingComponent *component = [super copyWithZone: zone];
    
    if (component) {
        component.owner = self.owner;
    }
    
    return component;
}

@end