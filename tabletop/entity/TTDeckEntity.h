//
//  TTDeckEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 19/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTDeckGroupingComponent.h"

@interface TTDeckEntity : TTEntity <NSCoding, NSCopying>

@property (readonly) TTDeckGroupingComponent *grouping;

@end
