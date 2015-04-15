//
// Created by Michael Kuck on 8/21/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "UIImageView+MKParallax.h"

//============================================================
//== Implementation
//============================================================
@implementation UIImageView (MKParallax)

- (void)addParallaxEffect
{
    self.backgroundColor = [UIColor colorWithPatternImage:self.image];
    self.image           = nil;
}

/**
* This method has to be called every time the scroll view did update
*
* @param scrollView The scrollView that the parallax effect should be linked to
*/
- (void)updateParallaxEffectWithScrollView:(UIScrollView *)scrollView
{
    CGFloat scrollOffset       = scrollView.contentOffset.y;
    CGRect  parallaxImageFrame = self.frame;

    parallaxImageFrame.origin.y = -scrollOffset / 4;
    if (scrollOffset > 0) {
        // TODO: is this a good way in terms of performance?
        parallaxImageFrame.size.height += fabsf(scrollOffset);
    } else if (scrollOffset < 0) {

    }

    self.frame = parallaxImageFrame;
}

@end