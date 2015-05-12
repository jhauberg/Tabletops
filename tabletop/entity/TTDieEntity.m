//
//  TTDieEntity.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 11/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDieEntity.h"

NSString* const kTTDieEntityRepresentationKey = @"representation";

@implementation TTDieEntity {
 @private
    TTDieRepresentation *_representation;
}

+ (instancetype) dieWithSides: (NSArray *) sides {
    TTDieEntity *die = [self entity];

    if (die) {
        die.representation.sides = sides;
    }

    return die;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _representation = [decoder decodeObjectForKey: kTTDieEntityRepresentationKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
    [encoder encodeObject: _representation forKey: kTTDieEntityRepresentationKey];
}

- (TTDieRepresentation *) representation {
    if (!_representation) {
        _representation = [TTDieRepresentation representation];
        
        [self addComponent: _representation];
    }
    
    return _representation;
}

- (BOOL) removeComponent: (TTEntityComponent *) component {
    if (component == _representation) {
        return NO;
    }
    
    return [super removeComponent: component];
}

@end
