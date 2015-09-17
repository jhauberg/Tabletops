//
//  TTDeckGroupingComponent+Additions.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/04/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTDeckGroupingComponent+Additions.h"

@implementation TTDeckGroupingComponent (Additions)

- (NSArray<__kindof TTEntity *> *) drawUsingSelector: (SEL) selector until: (TTEntityConditional) condition inclusive: (BOOL) inclusive {
    NSMutableArray<__kindof TTEntity *> *cards = [[NSMutableArray alloc] init];
    
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

- (NSArray<__kindof TTEntity *> *) drawFromBottomUntil: (TTEntityConditional) condition {
    return [self drawFromBottomUntil: condition
                           inclusive: YES];
}

- (NSArray<__kindof TTEntity *> *) drawFromBottomUntil: (TTEntityConditional) condition inclusive: (BOOL) inclusive {
    return [self drawUsingSelector: @selector(drawFromBottom)
                             until: condition
                         inclusive: inclusive];
}

- (NSArray<__kindof TTEntity *> *) drawFromTopUntil: (TTEntityConditional) condition {
    return [self drawFromTopUntil: condition
                        inclusive: YES];
}

- (NSArray<__kindof TTEntity *> *) drawFromTopUntil: (TTEntityConditional) condition inclusive: (BOOL) inclusive {
    return [self drawUsingSelector: @selector(drawFromTop)
                             until: condition
                         inclusive: inclusive];
}

@end
