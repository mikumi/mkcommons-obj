//
// Created by Michael Kuck on 6/26/14.
// Copyright (c) 2014 Jaysquared. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MFMailComposeViewController;

//============================================================
//== Public Interface
//============================================================
@interface MKEmailHelper : NSObject

- (void)openEmailScreenFromViewController:(UIViewController *)parentViewController recipients:(NSArray *)recipients
                                  subject:(NSString *)subject;
- (BOOL)isVisible;

@end
