//
//  TTEntityGroupingComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTEntityComponent.h"

@class TTEntity;

@interface TTEntityGroupingComponent : TTEntityComponent <NSCoding, NSCopying> {
 @protected
    NSMutableArray *_entities;
}

@property (readonly) NSArray *entities;

- (BOOL) addEntity: (TTEntity *) entity;
- (BOOL) addEntities: (NSArray *) entities;
- (BOOL) removeEntity: (TTEntity *) entity;

@end
