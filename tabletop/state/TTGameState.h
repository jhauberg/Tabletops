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
@interface TTGameState : NSObject <NSCoding, NSCopying>

/**
 Restore the state from default.
 */
+ (nullable instancetype) restore;
/**
 Restore the state from a file.
 */
+ (nullable instancetype) restoreFromFile: (nonnull NSString *) path;

/**
 Get the version of the application that this state was built with.
 */
@property (nonnull, readonly) NSNumber *version;

/**
 Get the root entity of the tabletop; the table itself.
 */
@property (nonnull, readonly) TTTableEntity *table;

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
- (BOOL) saveToFile: (nonnull NSString *) path;
/**
 Save the current state to a file, in a humanly readable format if specified.
 
 @returns YES if the state was saved, NO otherwise.
 */
- (BOOL) saveToFile: (nonnull NSString *) path asHumanlyReadable: (BOOL) humanlyReadable;

/**
 Find an entity on the table with a given tag. This searches through the entire table and all its groups.
 */
- (nullable id) findEntityTagged: (nonnull NSString *) tag;
/**
 Find an entity on the table with a given name. This searches through the entire table and all its groups.
 */
- (nullable id) findEntityNamed: (nonnull NSString *) name;

/**
 Find all entities on the table with a given tag. This searches through the entire table and all its groups.
 */
- (nonnull NSArray<__kindof TTEntity *> *) findEntitiesTagged: (nonnull NSString *) tag;
/**
 Find all entities on the table with a given name. This searches through the entire table and all its groups.
 */
- (nonnull NSArray<__kindof TTEntity *> *) findEntitiesNamed: (nonnull NSString *) name;

@end
