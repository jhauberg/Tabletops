//
//  TTDeckGroupingComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 18/09/14.
//  Copyright (c) 2014 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDeckGroupingComponent.h"
#import "TTEntity.h"

@implementation TTDeckGroupingComponent

- (TTEntity *) top {
    return [_entities lastObject];
}

- (TTEntity *) bottom {
    return [_entities firstObject];
}

- (TTEntity *) drawCard: (TTEntity *) card {
    if ([_entities containsObject: card]) {
        [_entities removeObject: card];
        
        return card;
    }
    
    return nil;
}

- (TTEntity *) drawCardFromTop {
    TTEntity *topCard = self.top;
    
    [_entities removeObject: topCard];
    
    return topCard;
}

- (TTEntity *) drawCardFromBottom {
    TTEntity *bottomCard = self.bottom;
    
    [_entities removeObject: bottomCard];
    
    return bottomCard;
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

- (TTEntity *) drawCardAtIndex: (NSUInteger) index {
    return [_entities objectAtIndex: index];
}

- (void) shuffle {
    for (NSUInteger i = 0; i < [_entities count]; ++i) {
        NSUInteger remainingCount = [_entities count] - i;
        NSUInteger exchangeIndex = i + arc4random_uniform((uint32_t)remainingCount);
        
        [_entities exchangeObjectAtIndex: i
                       withObjectAtIndex: exchangeIndex];
    }
}

- (void) sort {
    // todo: default to sorting by 'like'-ness, where similar ones go together.
}

- (void) sortBy: (TTPropertyComponent *) propertyComponent {
    [_entities sortUsingComparator: ^NSComparisonResult(id left, id right) {
        TTEntity *entity = (TTEntity *)left;
        TTEntity *otherEntity = (TTEntity *)right;

        TTPropertyComponent *property = [entity getComponentLike: propertyComponent];
        TTPropertyComponent *otherProperty = [otherEntity getComponentLike: propertyComponent];

        if (property && otherProperty) {
            return [property compare:
                    otherProperty];
        }
        
        return NSOrderedAscending;
    }];
}

- (void) sort: (NSComparator) comparison {
    [_entities sortUsingComparator: comparison];
}

@end
