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

NSString* const kTTDeckGroupingComponentDrawsFaceUpKey = @"draws_face_up";

@implementation TTDeckGroupingComponent

- (id) init {
    if (((self = [super init]))) {
        self.drawsFaceUp = YES;
    }
    
    return self;
}

- (id) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        self.drawsFaceUp = [decoder decodeBoolForKey: kTTDeckGroupingComponentDrawsFaceUpKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeBool: _drawsFaceUp forKey: kTTDeckGroupingComponentDrawsFaceUpKey];
}

- (id) copyWithZone: (NSZone *) zone {
    TTDeckGroupingComponent *component = [super copyWithZone: zone];
    
    if (component) {
        component.drawsFaceUp = self.drawsFaceUp;
    }
    
    return component;
}

- (TTEntity *) top {
    return [_entities lastObject];
}

- (TTEntity *) bottom {
    return [_entities firstObject];
}

- (TTEntity *) drawCardAtIndex: (NSUInteger) index {
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

- (TTEntity *) drawCard: (TTEntity *) card {
    if (card) {
        NSUInteger indexOfCard = [_entities indexOfObject: card];
        
        if (indexOfCard != NSNotFound) {
            return [self drawCardAtIndex:
                    indexOfCard];
        }
    }
    
    return nil;
}

- (TTEntity *) drawCardFromTop {
    return [self drawCard:
            self.top];
}

- (TTEntity *) drawCardFromBottom {
    return [self drawCard:
            self.bottom];
}

- (NSArray *) drawCardsFromTop: (NSUInteger) amount {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < amount; i++) {
        [cards addObject:
         [self drawCard:
          self.top]];
    }
    
    return [NSArray arrayWithArray:
            cards];
}

- (NSArray *) drawCardsFromBottom: (NSUInteger) amount {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < amount; i++) {
        [cards addObject:
         [self drawCard:
          self.bottom]];
    }
    
    return [NSArray arrayWithArray:
            cards];
}

- (TTEntity *) drawCardAtRandom {
    return [self drawCardAtIndex:
            rand() % [_entities count]];
}

- (NSArray *) drawCardsAtRandom: (NSUInteger) amount {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < amount; i++) {
        [cards addObject:
         [self drawCardAtRandom]];
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
