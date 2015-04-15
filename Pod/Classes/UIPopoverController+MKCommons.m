//
//  UIPopoverController+MKCommons.m
//  MKCommons
//
//  Created by Michael Kuck on 6/26/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <objc/runtime.h>
#import "UIPopoverController+MKCommons.h"

//============================================================
//== Implementation
//============================================================
@implementation UIPopoverController (MKCommons)

/**
* // DOCU: this method comment needs be updated.
*/
- (void)setParentViewController:(UIViewController *)parentViewController
{
    objc_setAssociatedObject(self, @selector(parentViewController), parentViewController, OBJC_ASSOCIATION_ASSIGN);
}

/**
* // DOCU: this method comment needs be updated.
*/
- (UIViewController *)parentViewController
{
    return objc_getAssociatedObject(self, @selector(parentViewController));
}

@end
