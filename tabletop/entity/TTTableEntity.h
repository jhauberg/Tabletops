//
//  TTTableEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTEntityGroupingComponent.h"

@interface TTTableEntity : TTEntity

+ (TTTableEntity *) table;

@property (readonly) TTEntityGroupingComponent *grouping;

@end
