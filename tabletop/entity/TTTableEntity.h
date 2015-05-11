//
//  TTTableEntity.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTEntityGroupingComponent.h"

/**
 Provides a common implementation of a tabletop.
 */
@interface TTTableEntity : TTEntity

/**
 Get the grouping component for the contents of the table. Can not be removed.
 
 Note that this component is only created and assigned when first used.
 */
@property (readonly) TTEntityGroupingComponent *group;

/**
 Clear all entities from the table, restoring its default state.
 
 @returns YES if the table was cleared, otherwise NO.
 */
- (BOOL) clear;

@end
