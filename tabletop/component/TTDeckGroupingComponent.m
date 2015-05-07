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

- (instancetype) init {
    if (((self = [super init]))) {
        self.addsFaceDown = YES;
        self.drawsFaceUp = YES;
    }
    
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        self.addsFaceDown = [decoder decodeBoolForKey: kTTDeckGroupingComponentAddsFaceDownKey];
        self.drawsFaceUp = [decoder decodeBoolForKey: kTTDeckGroupingComponentDrawsFaceUpKey];
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];
    
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
    
    TTCardRepresentation *cardRepresentation = [entity getComponentOfType:
                                                [TTCardRepresentation class]];
    
    if (cardRepresentation) {
        if (self.addsFaceDown && cardRepresentation.isFaceUp) {
            [cardRepresentation flip];
        }
    }
    
    return result;
}

/**
 Sorts entities by their card representation.

 The comparison is based on the front and back images of any card representation components present on the compared entities.
 No sorting occurs if either of the compared entities do not have a card representation component.
 */
- (void) sort {
    [_entities sortUsingComparator:
     ^NSComparisonResult(id left, id right) {
         TTEntity *entity = (TTEntity *)left;
         TTEntity *otherEntity = (TTEntity *)right;

         TTCardRepresentation *cardRepresentation = [entity getComponentOfType:
                                                     [TTCardRepresentation class]];
         TTCardRepresentation *otherCardRepresentation = [otherEntity getComponentOfType:
                                                          [TTCardRepresentation class]];

         if (cardRepresentation && otherCardRepresentation) {
             NSComparisonResult comparison = [self compare: cardRepresentation.backside
                                                        to: otherCardRepresentation.backside];

             if (comparison != NSOrderedSame) {
                 return comparison;
             }

             comparison = [self compare: cardRepresentation.frontside
                                     to: otherCardRepresentation.frontside];

             if (comparison != NSOrderedSame) {
                 return comparison;
             }
         }

         return NSOrderedSame;
     }];
}

- (NSComparisonResult) compare: (id<NSCoding, NSObject, NSCopying>) leftObject to: (id<NSCoding, NSObject, NSCopying>) rightObject {
    NSComparisonResult comparisonResult = NSOrderedSame;

    SEL comparisonSelector = @selector(compare:);

    if ([leftObject respondsToSelector: comparisonSelector] &&
        [rightObject respondsToSelector: comparisonSelector]) {
        NSMethodSignature *signature = [NSString instanceMethodSignatureForSelector: comparisonSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: signature];

        [invocation setTarget: leftObject];
        [invocation setSelector: comparisonSelector];
        [invocation setArgument: &rightObject atIndex: 2];
        [invocation invoke];

        [invocation getReturnValue: &comparisonResult];
    }

    return comparisonResult;
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
        card = _entities[index];
        
        if (card) {
            [_entities removeObjectAtIndex: index];

            TTCardRepresentation *cardRepresentation = [card getComponentOfType:
                                                        [TTCardRepresentation class]];

            if (cardRepresentation) {
                if (self.drawsFaceUp && !cardRepresentation.isFaceUp) {
                    [cardRepresentation flip];
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
        TTEntity *card = [self draw:
                          self.top];
        
        if (!card) {
            break;
        }
        
        [cards addObject:
         card];
    }
    
    return [NSArray arrayWithArray:
            cards];
}

- (NSArray *) drawFromBottom: (NSUInteger) amount {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < amount; i++) {
        TTEntity *card = [self draw:
                          self.bottom];
        
        if (!card) {
            break;
        }
        
        [cards addObject:
         card];
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
        TTEntity *card = [self drawAtRandom];
        
        if (!card) {
            break;
        }
        
        [cards addObject:
         card];
    }
    
    return [NSArray arrayWithArray:
            cards];
}

- (BOOL) addEntityToBottom: (TTEntity *) entity {
    if ([self addEntity: entity]) {
        return [self sendToBottom: entity];
    }
    
    return NO;
}

- (BOOL) sendToBottom: (TTEntity *) card {
    if (!card) {
        return NO;
    }
    
    if (![_entities containsObject: card]) {
        return [self addEntityToBottom: card];
    }
    
    [_entities removeObject: card];
    [_entities insertObject: card
                    atIndex: 0];
    
    return YES;
}

- (BOOL) bringToTop: (TTEntity *) card {
    if (!card) {
        return NO;
    }
    
    if (![_entities containsObject: card]) {
        return [self addEntity: card];
    }

    [_entities removeObject: card];
    [_entities addObject: card];

    return YES;
}

- (void) shuffle {
    if ([_entities count] > 0) {
        for (NSUInteger i = 0; i < [_entities count]; ++i) {
            NSUInteger remainingCount = [_entities count] - i;
            NSUInteger exchangeIndex = i + arc4random_uniform((uint32_t)remainingCount);
            
            [_entities exchangeObjectAtIndex: i
                           withObjectAtIndex: exchangeIndex];
        }
    }
}

@end
