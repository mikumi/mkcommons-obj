//
//  UIViewController+MKCommons.h
//  MKCommons
//
//  Created by Michael Kuck on 6/26/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <UIKit/UIKit.h>

//============================================================
//== Public Interface
//============================================================
@interface UIViewController (MKCommons)

@property (strong, nonatomic) UIPopoverController *popoverController;

- (BOOL)isVisible;

@end
