//
//  TTGameState.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTGameState.h"

NSUInteger const kTTGameStateVersion = 1;
NSString* const kTTGameStateDefaultFilename = @"state";

NSString* const kTTGameStateVersionKey = @"version";
NSString* const kTTGameStateTableKey = @"table";

@implementation TTGameState

+ (TTGameState *) restore {
    return [TTGameState restoreFromFile:
            kTTGameStateDefaultFilename];
}

+ (TTGameState *) restoreFromFile: (NSString*) path {
    return (TTGameState *)[NSKeyedUnarchiver unarchiveObjectWithFile:
                           path];
}

- (id) init {
    if ((self = [super init])) {
        _version = @(kTTGameStateVersion);
        _table = [TTTableEntity table];
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super init])) {
        _version = [decoder decodeObjectForKey: kTTGameStateVersionKey];
        
        if (_version) {
            NSNumber *runningVersion = @(kTTGameStateVersion);
            
            if ([_version isNotEqualTo: runningVersion]) {
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
            NSLog(@"error: %@", error);
            
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"\nTable: %@", [_table description]];
}

@end
