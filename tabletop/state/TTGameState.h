//
//  TTGameState.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTableEntity.h"

/**
 Represents the current state of the tabletop.
 */
@interface TTGameState : NSObject <NSCoding>

/**
 Restore the state from default.
 */
+ (TTGameState *) restore;
/**
 Restore the state from a file.
 */
+ (TTGameState *) restoreFromFile: (NSString*) path;

/**
 The version of the application that this state was built with.
 */
@property (readonly) NSNumber *version;

/**
 The root entity of the tabletop; the table itself.
 */
@property (readonly) TTTableEntity *table;

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
