//
//  TTTagComponent.m
//  Tabletops
//
//  Created by Jacob Hauberg Hansen on 15/05/15.
//  Copyright (c) 2015 Jacob Hauberg Hansen. All rights reserved.
//

#import "TTTagComponent.h"

NSString* const kTTTagComponentTagKey = @"tag";

@implementation TTTagComponent

+ (instancetype) componentWithTag: (NSString *) tag {
    return [[[self class] alloc] initWithTag: tag];
}

- (instancetype) initWithTag: (NSString *) tag {
    if ((self = [self init])) {
        _tag = tag;
    }

    return self;
}

- (instancetype) initWithCoder: (NSCoder *) decoder {
    if ((self = [super initWithCoder: decoder])) {
        _tag = [decoder decodeObjectForKey: kTTTagComponentTagKey];
    }

    return self;
}

- (void) encodeWithCoder: (NSCoder *) encoder {
    [super encodeWithCoder: encoder];

    [encoder encodeObject: _tag forKey: kTTTagComponentTagKey];
}

- (NSComparisonResult) compare: (TTTagComponent *) otherTag {
    return [self.tag compare: otherTag.tag];
}

/**
 A different tag component is considered to be equal to this component if the tag matches a case-sensitive comparison
 */
- (BOOL) isEqual: (id) object {
    if ([super isEqual: object]) {
        return [self.tag isEqualToString: ((TTTagComponent *)object).tag];
    }

    return NO;
}

/**
 A different tag component is considered to be like this component if the tag matches a case-insensitive comparison.
 */
- (BOOL) isLike: (TTEntityComponent *) otherComponent {
    if ([super isLike: otherComponent]) {
        return [self.tag caseInsensitiveCompare: ((TTTagComponent *)otherComponent).tag] == NSOrderedSame;
    }

    return NO;
}

- (NSString *) description {
    return [NSString stringWithFormat:
            @"<%@: %p> \"%@\"", self.class, self, self.tag];
}

- (NSString *) shortDescription {
    return [NSString stringWithFormat:
            @"%@ (\"%@\")", self.class, self.tag];
}

@end
