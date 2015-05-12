//
//  TTEntityComponent.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Base class for implementing an entity component.
 */
@interface TTEntityComponent : NSObject <NSCoding, NSCopying>

/**
 Determine whether a component is similar to the receiver.
 
 @returns YES if the otherComponent is similar, otherwise NO.
 */
- (BOOL) isLike: (TTEntityComponent *) otherComponent;

- (NSString *) shortDescription;

@end
