//
// Created by Michael Kuck on 1/23/15.
// Copyright (c) 2015 Michael Kuck. All rights reserved.
//

#import "UISegmentedControl+MKCommons.h"

//============================================================
//== Implementation
//============================================================
@implementation UISegmentedControl (MKCommons)

- (void)setSegmentTitles:(NSArray *)titles
{
    [self removeAllSegments];
    if (titles) {
        [titles enumerateObjectsUsingBlock:^(id title, NSUInteger idx, BOOL *stop) {
            NSAssert([title isKindOfClass:[NSString class]], @"titles should only contain NSString");
            [self insertSegmentWithTitle:title atIndex:idx animated:NO];
        }];
    }
}

- (NSArray *)segmentTitles
{
    NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:self.numberOfSegments];
    for (NSUInteger i = 0; i < self.numberOfSegments; i++) {
        [titles addObject:[self titleForSegmentAtIndex:i]];
    }
    return titles;
}

@end