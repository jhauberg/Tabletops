//
//  TTEntityComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTEntityComponent : NSObject <NSCoding, NSCopying>

- (BOOL) isLike: (TTEntityComponent *) otherComponent;

@end
