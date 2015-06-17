//
//  Tabletops.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 16/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#ifndef TABLETOPS_H
#define TABLETOPS_H

#ifdef DEBUG
  #ifndef SHOW_RUNTIME_WARNINGS
    #define SHOW_RUNTIME_WARNINGS 1
    #define SHOW_ALL_RUNTIME_WARNINGS 0
  #endif
  #ifndef SHOW_RULE_RESOLUTION
    #define SHOW_RULE_RESOLUTION 1
  #endif
#endif

#import <Foundation/Foundation.h>

#import "TTEntity.h"
#import "TTEntity+Additions.h"

#import "TTEntityComponent.h"

#import "TTEntityGroupingComponent.h"
#import "TTEntityGroupingComponent+Additions.h"

#import "TTGameState.h"

#endif
