//
//  TTPropertyComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTEntityComponent.h"

@interface TTPropertyComponent : TTEntityComponent <NSCoding, NSCopying>

@property (readonly) NSString *name;

@property (strong) id<NSCoding, NSObject> value;

- (id) initWithName: (NSString *) name andValue: (id<NSCoding, NSObject>) value;

- (NSComparisonResult) compare: (TTPropertyComponent *) otherProperty;

@end
