//
//  TTEntity+Additions.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 30/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTEntity.h"
#import "TTPropertyComponent.h"
#import "TTTagComponent.h"

@interface TTEntity (Additions)

- (nonnull NSArray *) getAllTags;

- (nullable TTTagComponent *) getTagWithName: (nonnull NSString *) tag;
- (nullable TTPropertyComponent *) getPropertyWithName: (nonnull NSString *) name;

- (BOOL) isTaggedWithName: (nonnull NSString *) name;
- (BOOL) hasPropertyWithName: (nonnull NSString *) name;

- (BOOL) moveComponent: (nonnull TTEntityComponent *) component fromEntity: (nonnull TTEntity *) entity;
- (BOOL) moveComponent: (nonnull TTEntityComponent *) component toEntity: (nonnull TTEntity *) entity;

@end
