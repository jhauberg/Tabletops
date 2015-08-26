//
//  TTGameState.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "Tabletops.h"

#import "TTGameState.h"

#import "TTEntityGroupingComponent+Additions.h"

NSUInteger const kTTGameStateVersion = 1;

NSString* const kTTGameStateDefaultFilename = @"state";

NSString* const kTTGameStateVersionKey = @"version";
NSString* const kTTGameStateTableKey = @"table";

@implementation TTGameState

+ (instancetype) restore {
    return [self restoreFromFile:
            kTTGameStateDefaultFilename];
}

+ (instancetype) restoreFromFile: (NSString*) path {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:
            path];
}

- (instancetype) init {
    if ((self = [super init])) {
        _version = @(kTTGameStateVersion);
        _table = [TTTableEntity entity];
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super init])) {
        _version = [decoder decodeObjectForKey: kTTGameStateVersionKey];

        if (_version) {
            NSNumber *runningVersion = @(kTTGameStateVersion);

            if (![_version isEqualToNumber: runningVersion]) {
                [NSException raise: @"The game state being restored was created in a different version of the application"
                            format: @"Currently running version '%@', but the game state was saved in version '%@'", runningVersion, _version];
            }
        }

        _table = [decoder decodeObjectForKey: kTTGameStateTableKey];
    }

    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: _version forKey: kTTGameStateVersionKey];
    [encoder encodeObject: _table forKey: kTTGameStateTableKey];
}

- (id) copyWithZone: (NSZone *) zone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:
            [NSKeyedArchiver archivedDataWithRootObject:
             self]];
}

- (BOOL) save {
    return [self saveAsHumanlyReadable:
            NO];
}

- (BOOL) saveAsHumanlyReadable: (BOOL) humanlyReadable {
    return [self saveToFile: kTTGameStateDefaultFilename
          asHumanlyReadable: humanlyReadable];
}

- (BOOL) saveToFile: (NSString *) path {
    return [self saveToFile: path
          asHumanlyReadable: NO];
}

- (BOOL) saveToFile: (NSString *) path asHumanlyReadable: (BOOL) humanlyReadable {
    NSData *data = nil;
    
    if (humanlyReadable) {
        NSMutableData *mutableData = [NSMutableData data];
        
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:
                                     mutableData];
        
        [archiver setOutputFormat:
         NSPropertyListXMLFormat_v1_0];
        
        [archiver encodeObject: self
                        forKey: path];
        
        [archiver finishEncoding];
        
        data = [NSData dataWithData:
                mutableData];
    } else {
        data = [NSKeyedArchiver archivedDataWithRootObject:
                self];
    }
    
    if (data) {
        NSError *error = nil;
        
        [data writeToFile: path
                  options: NSDataWritingAtomic
                    error: &error];
        
        if (error) {
            TTDebugWarning(@"error: %@", error);
            
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

- (id) findEntityTagged: (NSString *) tag {
    id entity = [self.table.group getEntityWithTag: tag];
    
    if (!entity) {
        TTDebugWarning(@"Could not find any entity tagged with '%@'", tag);
    }
    
    return entity;
}

- (id) findEntityNamed: (NSString *) name {
    id entity = [self.table.group getEntityWithName: name];
    
    if (!entity) {
        TTDebugWarning(@"Could not find any entity named '%@'", name);
    }
    
    return entity;
}

- (NSArray *) findEntitiesTagged: (NSString *) tag {
    NSArray *entities = [self.table.group getEntitiesWithTag: tag];
    
    if (!entities || [entities count] == 0) {
        TTDebugWarning(@"Could not find any entities tagged with '%@'", tag);
    }
    
    return entities;
}

- (NSArray *) findEntitiesNamed: (NSString *) name {
    NSArray *entities = [self.table.group getEntitiesWithName: name];
    
    if (!entities || [entities count] == 0) {
        TTDebugWarning(@"Could not find any entities named '%@'", name);
    }
    
    return entities;
}

- (NSString *) description {
    NSUInteger totalEntityCount = self.table.group.countIncludingChildGroupings + 1; // include table entity

    return [NSString stringWithFormat:
            @"\nTable %@ (%@): %@",
            self.version,
            [NSString stringWithFormat:
             @"%lu %@",
             totalEntityCount,
             totalEntityCount == 1 ? @"entity" : @"entities"],
            self.table];
}

@end
