//
//  TTGameState.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTGameState.h"

@implementation TTGameState

- (id) init {
    if ((self = [super init])) {
        _table = [[TTTableEntity alloc] init];
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super init])) {
        _table = [decoder decodeObjectForKey: @"table"];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: _table forKey: @"table"];
}

- (BOOL) save {
    return [self saveAsHumanlyReadable:
            NO];
}

- (BOOL) saveAsHumanlyReadable: (BOOL) humanlyReadable {
    NSData *data = nil;
    
    if (humanlyReadable) {
        NSMutableData *mutableData = [NSMutableData data];
        
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:
                                     mutableData];
        
        [archiver setOutputFormat: NSPropertyListXMLFormat_v1_0];
        [archiver encodeObject: self
                        forKey: @"state"];
        [archiver finishEncoding];
        
        data = [NSData dataWithData:
                mutableData];
    } else {
        data = [NSKeyedArchiver archivedDataWithRootObject:
                self];
    }
    
    NSError *error = nil;
    
    if (!error) {
        [data writeToFile: @"state"
                  options: NSDataWritingAtomic
                    error: &error];
        
        return YES;
    } else {
        NSLog(@"error: %@", error);
    }
    
    return NO;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"\nTable: %@", [_table description]];
}

+ (TTGameState *) restore {
    return (TTGameState *)[NSKeyedUnarchiver unarchiveObjectWithFile:
                           @"state"];
}

@end
