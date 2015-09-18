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

- (BOOL) addEntity: (id) entity {
    BOOL result = [super addEntity: entity];
    
    TTCardRepresentation *cardRepresentation = [entity getComponentOfType:
                                                [TTCardRepresentation class]];
    
    if (cardRepresentation) {
        if (self.addsFaceDown) {
            [cardRepresentation flipToBackside];
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

- (id) top {
    return [_entities lastObject];
}

- (id) bottom {
    return [_entities firstObject];
}

- (id) drawAtIndex: (NSUInteger) index {
    TTEntity *card = nil;
    
    if (index < _entities.count) {
        card = _entities[index];
        
        if (card) {
            [_entities removeObjectAtIndex: index];

            TTCardRepresentation *cardRepresentation = [card getComponentOfType:
                                                        [TTCardRepresentation class]];

            if (cardRepresentation) {
                if (self.drawsFaceUp) {
                    [cardRepresentation flipToFrontside];
                }
            }
        }
    }
    
    return card;
}

- (id) draw: (TTEntity *) card {
    if (card) {
        NSUInteger indexOfCard = [_entities indexOfObject: card];
        
        if (indexOfCard != NSNotFound) {
            return [self drawAtIndex:
                    indexOfCard];
        }
    }
    
    return nil;
}

- (NSArray *) drawUsingSelector: (SEL) selector until: (TTEntityConditional) condition inclusive: (BOOL) inclusive {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    if ([self respondsToSelector: selector]) {
        TTEntity *card = nil;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        while (!condition((card = [self performSelector: selector]))) {
#pragma clang diagnostic pop
            if (!card) {
                break;
            }
            
            [cards addObject:
             card];
        }
        
        if (card && inclusive) {
            [cards addObject:
             card];
        }
    }
    
    return [NSArray arrayWithArray:
            cards];
}

- (id) drawFromTop {
    return [self draw:
            self.top];
}

- (id) drawFromBottom {
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

- (NSArray *) drawFromTopUntil: (TTEntityConditional) condition {
    return [self drawFromTopUntil: condition
                        inclusive: YES];
}

- (NSArray *) drawFromTopUntil: (TTEntityConditional) condition inclusive: (BOOL) inclusive {
    return [self drawUsingSelector: @selector(drawFromTop)
                             until: condition
                         inclusive: inclusive];
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

- (NSArray *) drawFromBottomUntil: (TTEntityConditional) condition {
    return [self drawFromBottomUntil: condition
                           inclusive: YES];
}

- (NSArray *) drawFromBottomUntil: (TTEntityConditional) condition inclusive: (BOOL) inclusive {
    return [self drawUsingSelector: @selector(drawFromBottom)
                             until: condition
                         inclusive: inclusive];
}

- (id) drawAtRandom {
    return [self drawAtIndex:
            arc4random_uniform((uint32_t)[_entities count])];
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

- (BOOL) addEntityToBottom: (id) entity {
    if ([self addEntity: entity]) {
        return [self sendToBottom: entity];
    }
    
    return NO;
}

- (BOOL) sendToBottom: (id) card {
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

- (BOOL) bringToTop: (id) card {
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
    if ([_entities count] > 1) {
        for (NSUInteger currentIndex = 0; currentIndex < [_entities count]; ++currentIndex) {
            NSUInteger remainingCount = [_entities count] - currentIndex;
            NSUInteger exchangeIndex = currentIndex + arc4random_uniform((uint32_t)remainingCount);
            
            [_entities exchangeObjectAtIndex: currentIndex
                           withObjectAtIndex: exchangeIndex];
        }
    }
}

@end
