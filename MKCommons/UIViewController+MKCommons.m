//
//  UIViewController+MKCommons.m
//  MKCommons
//
//  Created by Michael Kuck on 6/26/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "UIViewController+MKCommons.h"

static UIPopoverController *_mkPopoverController; // I would name it _popoverController, but that will nameclash with Apple's internal _popoverController

//============================================================
//== Implementation
//============================================================
@implementation UIViewController (MKCommons)

/**
* // DOCU: this method comment needs be updated.
*/
- (void)setPopoverController:(UIPopoverController *)popoverController
{
    _mkPopoverController = popoverController;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (UIPopoverController *)popoverController
{
    return _mkPopoverController;
}

@end
