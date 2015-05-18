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

- (NSArray *) getAllTags;

- (TTTagComponent *) getTagWithName: (NSString *) tag;
- (TTPropertyComponent *) getPropertyWithName: (NSString *) name;

- (BOOL) moveComponent: (TTEntityComponent *) component fromEntity: (TTEntity *) entity;
- (BOOL) moveComponent: (TTEntityComponent *) component toEntity: (TTEntity *) entity;

@end
