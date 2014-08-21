//
// Created by Michael Kuck on 8/21/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

//============================================================
//== Public Interface
//============================================================
@interface UIImageView (MKParallax)

- (void)addParallaxEffect;
- (void)updateParallaxEffectWithScrollView:(UIScrollView *)scrollView;

@end