//
//  TTDeckGroupingComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDeckGroupingComponent.h"
#import "TTCardRepresentation.h"
#import "TTEntity.h"

NSString* const kTTDeckGroupingComponentAddsFaceDownKey = @"adds_face_down";
NSString* const kTTDeckGroupingComponentDrawsFaceUpKey = @"draws_face_up";

@implementation TTDeckGroupingComponent

- (id) init {
    if (((self = [super init]))) {
        self.addsFaceDown = YES;
        self.drawsFaceUp = YES;
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        self.addsFaceDown = [decoder decodeBoolForKey: kTTDeckGroupingComponentAddsFaceDownKey];
        self.drawsFaceUp = [decoder decodeBoolForKey: kTTDeckGroupingComponentDrawsFaceUpKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeBool: _addsFaceDown forKey: kTTDeckGroupingComponentAddsFaceDownKey];
    [encoder encodeBool: _drawsFaceUp forKey: kTTDeckGroupingComponentDrawsFaceUpKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTDeckGroupingComponent *component = [super copyWithZone: zone];
    
    if (component) {
        component.addsFaceDown = self.addsFaceDown;
        component.drawsFaceUp = self.drawsFaceUp;
    }
    
    return component;
}

- (BOOL) addEntity: (TTEntity *) entity {
    BOOL result = [super addEntity: entity];
    
    if (self.addsFaceDown) {
        TTCardRepresentation *cardRepresentation = [entity getComponentOfType:
                                                    [TTCardRepresentation class]];
        
        if (cardRepresentation) {
            if (!cardRepresentation.isFlipped) {
                [cardRepresentation flip];
            }
        }
    }
    
    return result;
}

- (TTEntity *) top {
    return [_entities lastObject];
}

- (TTEntity *) bottom {
    return [_entities firstObject];
}

- (TTEntity *) drawAtIndex: (NSUInteger) index {
    TTEntity *card = nil;
    
    if (index < _entities.count) {
        card = [_entities objectAtIndex: index];
        
        if (card) {
            [_entities removeObjectAtIndex: index];
            
            if (self.drawsFaceUp) {
                TTCardRepresentation *cardRepresentation = [card getComponentOfType:
                                                            [TTCardRepresentation class]];
                
                if (cardRepresentation) {
                    if (cardRepresentation.isFlipped) {
                        [cardRepresentation flip];
                    }
                }
            }
        }
    }
    
    return card;
}

- (TTEntity *) draw: (TTEntity *) card {
    if (card) {
        NSUInteger indexOfCard = [_entities indexOfObject: card];
        
        if (indexOfCard != NSNotFound) {
            return [self drawAtIndex:
                    indexOfCard];
        }
    }
    
    return nil;
}

- (TTEntity *) drawFromTop {
    return [self draw:
            self.top];
}

- (TTEntity *) drawFromBottom {
    return [self draw:
            self.bottom];
}

- (NSArray *) drawFromTop: (NSUInteger) amount {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < amount; i++) {
        [cards addObject:
         [self draw:
          self.top]];
    }
    
    return [NSArray arrayWithArray:
            cards];
}

- (NSArray *) drawFromBottom: (NSUInteger) amount {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < amount; i++) {
        [cards addObject:
         [self draw:
          self.bottom]];
    }
    
    return [NSArray arrayWithArray:
            cards];
}

- (TTEntity *) drawAtRandom {
    return [self drawAtIndex:
            rand() % [_entities count]];
}

- (NSArray *) drawAtRandom: (NSUInteger) amount {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < amount; i++) {
        [cards addObject:
         [self drawAtRandom]];
    }
    
    return [NSArray arrayWithArray:
            cards];
}

- (void) shuffle {
    for (NSUInteger i = 0; i < [_entities count]; ++i) {
        NSUInteger remainingCount = [_entities count] - i;
        NSUInteger exchangeIndex = i + arc4random_uniform((uint32_t)remainingCount);
        
        [_entities exchangeObjectAtIndex: i
                       withObjectAtIndex: exchangeIndex];
    }
}

@end