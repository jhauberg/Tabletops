//
//  TTAreaGroupingComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 29/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityGroupingComponent.h"
#import "TTEntity.h"

@interface TTAreaGroupingComponent : TTEntityGroupingComponent

@property (assign) CGRect area;

- (BOOL) canAddEntity: (TTEntity *) entity;

@end
