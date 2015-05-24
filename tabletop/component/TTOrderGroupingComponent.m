//
//  TTOrderGroupingComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 21/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTOrderGroupingComponent.h"

@implementation TTOrderGroupingComponent {
 @private
    TTEntity *_currentEntity;
    TTEntity *_startingEntity;
}

- (TTEntity *) current {
    return _currentEntity;
}

- (TTEntity *) first {
    return _startingEntity;
}

- (TTEntity *) last {
    TTEntity *last = nil;

    if (self.count > 0) {
        NSInteger lastIndex = [_entities indexOfObject: _startingEntity] - 1;

        if (lastIndex >= 0) {
            last = _entities[lastIndex];
        } else {
            last = [_entities lastObject];
        }
    }

    return last;
}

- (TTEntity *) previous {
    TTEntity *previous = nil;

    if (!self.isEmpty) {
        NSInteger previousIndex = [_entities indexOfObject: _currentEntity] - 1;

        if (previousIndex >= 0) {
            previous = _entities[previousIndex];
        } else {
            previous = [_entities lastObject];
        }
    }
    
    return previous;
}

- (TTEntity *) next {
    TTEntity *next = nil;

    if (!self.isEmpty) {
        NSUInteger nextIndex = [_entities indexOfObject: _currentEntity] + 1;

        if (nextIndex < self.count) {
            next = _entities[nextIndex];
        } else {
            next = [_entities firstObject];
        }
    }
    
    return next;
}

- (void) moveToNext {
    _currentEntity = self.next;
}

- (void) moveToPrevious {
    _currentEntity = self.previous;
}

- (void) reset {
    _currentEntity = _startingEntity;
}

- (void) makeEntityFirstInOrder: (TTEntity *) entity {
    if ([_entities containsObject: entity]) {
        _startingEntity = entity;

        [self reset];
    }
}

- (BOOL) addEntity: (TTEntity *) entity {
    if ([super addEntity: entity]) {
        if (!_startingEntity) {
            _startingEntity = entity;

            [self reset];
        }

        return YES;
    }

    return NO;
}

- (BOOL) removeEntity: (TTEntity *) entity {
    if ([super removeEntity: entity]) {
        if (_currentEntity == entity) {
            _currentEntity = self.next;
        }

        if (_startingEntity == entity) {
            _startingEntity = _currentEntity;
        }

        return YES;
    }

    return NO;
}

@end