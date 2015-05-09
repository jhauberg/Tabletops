//
//  TTGameState.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntity.h"
#import "TTEntityGroupingComponent.h"

/**
 Represents the current state of the tabletop.
 */
@interface TTGameState : NSObject <NSCoding, NSCopying>

/**
 Restore the state from default.
 */
+ (instancetype) restore;
/**
 Restore the state from a file.
 */
+ (instancetype) restoreFromFile: (NSString*) path;

/**
 Get the version of the application that this state was built with.
 */
@property (readonly) NSNumber *version;

/**
 Get the root entity of the tabletop; the table itself.
 */
@property (readonly) TTEntity *table;
/**
 Get the grouping component for the @c table.
 */
@property (readonly) TTEntityGroupingComponent *entities;

/**
 Save the current state as default.
 
 @returns YES if the state was saved, NO otherwise.
 */
- (BOOL) save;
/**
 Save the current state as default, in a humanly readable format if specified.
 
 @returns YES if the state was saved, NO otherwise.
 */
- (BOOL) saveAsHumanlyReadable: (BOOL) humanlyReadable;

/**
 Save the current state to a file.
 
 @returns YES if the state was saved, NO otherwise.
 */
- (BOOL) saveToFile: (NSString *) path;
/**
 Save the current state to a file, in a humanly readable format if specified.
 
 @returns YES if the state was saved, NO otherwise.
 */
- (BOOL) saveToFile: (NSString *) path asHumanlyReadable: (BOOL) humanlyReadable;

@end
