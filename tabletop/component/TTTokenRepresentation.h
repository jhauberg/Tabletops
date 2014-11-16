//
//  TTTokenRepresentation.h
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTRepresentationComponent.h"

@interface TTTokenRepresentation : TTRepresentationComponent <NSCoding, NSCopying>

@property (strong) NSString *image;

@end
