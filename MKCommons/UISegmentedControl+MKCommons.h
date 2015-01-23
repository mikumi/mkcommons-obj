//
// Created by Michael Kuck on 1/23/15.
// Copyright (c) 2015 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

//============================================================
//== Public Interface
//============================================================
@interface UISegmentedControl (MKCommons)

- (void)setSegmentTitles:(NSArray *)titles;
- (NSArray *)segmentTitles;

@end