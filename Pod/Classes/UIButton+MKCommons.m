//
//  UIButton+MKCommons.m
//  MKCommons
//
//  Created by Michael Kuck on 6/9/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "UIButton+MKCommons.h"

static const int ButtonImageTitleDefaultSpacing = 6.0f;

//============================================================
//== Private Interface
//============================================================
@interface UIButton ()

@end

//============================================================
//== Implementation
//============================================================
@implementation UIButton (MKCommons)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
/**
 * // DOCU: this method comment needs be updated.
 */
- (void)centerImageAndTitle:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
//    CGSize titleSize = self.titleLabel.frame.size;
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                                        constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                            lineBreakMode:self.titleLabel.lineBreakMode];

    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);

    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);

    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(totalHeight - titleSize.height), 0.0);
}
#pragma clang diagnostic pop

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)centerImageAndTitle
{
    [self centerImageAndTitle:ButtonImageTitleDefaultSpacing];
}

@end
