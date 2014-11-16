//
//  TTCardRepresentation.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTRepresentationComponent.h"

@interface TTCardRepresentation : TTRepresentationComponent <NSCoding, NSCopying>

@property (strong) NSString *frontImage;
@property (strong) NSString *backImage;

@property (readonly) id visibleImage;

@property (readonly) BOOL isFlipped;
@property (readonly) BOOL isTapped;

- (void) flip;
- (void) tap;

@end
