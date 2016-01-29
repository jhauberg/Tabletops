//
//  Tabletops.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 16/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#ifndef TABLETOPS_H
#define TABLETOPS_H

#define TABLETOPS_VERSION @"0.1.0"
#define TABLETOPS_BUILD 1

#ifdef DEBUG
  #ifndef SHOW_RUNTIME_WARNINGS
    #define SHOW_RUNTIME_WARNINGS 1
  #endif

  #define TTDebug(format, ...) NSLog((@"" format), ##__VA_ARGS__)

  #if SHOW_RUNTIME_WARNINGS
    #define TTDebugWarning(format, ...) NSLog((@" *** " format), ##__VA_ARGS__)
  #else
    #define TTDebugWarning(...)
  #endif
#else
  #define TTDebug(...)
  #define TTDebugWarning(...)
#endif

#import <Foundation/Foundation.h>

#import "TTEntity.h"
#import "TTEntity+Additions.h"

#import "TTEntityComponent.h"

#import "TTEntityGroupingComponent.h"
#import "TTEntityGroupingComponent+Additions.h"

#import "TTGameState.h"

#endif
