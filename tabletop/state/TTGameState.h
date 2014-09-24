//
//  TTGameState.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTTableEntity.h"

@interface TTGameState : NSObject <NSCoding>

+ (TTGameState *) restore;

@property (readonly) TTTableEntity *table;

- (BOOL) save;
- (BOOL) saveAsHumanlyReadable: (BOOL) humanlyReadable;

@end
