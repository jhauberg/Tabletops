//
//  TTAreaGroupingComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 29/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent.h"
#import "TTEntity.h"

/**
 Groups entities within a bounded area.
 */
@interface TTAreaGroupingComponent : TTEntityGroupingComponent

@property (assign) CGRect area;

/**
 Determine whether an entity is within bounds of the area.
 
 @returns YES if it is within bounds, NO otherwise.
 */
- (BOOL) canAddEntity: (TTEntity *) entity;

@end
