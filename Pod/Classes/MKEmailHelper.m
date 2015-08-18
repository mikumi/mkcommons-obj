//
// Created by Michael Kuck on 6/26/14.
// Copyright (c) 2014 Jaysquared. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "MKEmailHelper.h"

#import "UIViewController+MKCommons.h"
#import "MKLog.h"

//============================================================
//== Private Interface
//============================================================
@interface MKEmailHelper ()<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) MFMailComposeViewController *mailController;

@property (weak, nonatomic) UIViewController            *parentViewController;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKEmailHelper

/**
* // DOCU: this method comment needs be updated.
*/
- (void)openEmailScreenFromViewController:(UIViewController *)parentViewController recipients:(NSArray *)recipients
                                  subject:(NSString *)subject;
{
    if ([self.mailController isVisible]) {
        MKLogWarning(@"Mail controller already visible. Not pushing another one.");
        return;
    }

    MKLogInfo(@"Opening email app for sending a support mail...");
    self.mailController                     = [[MFMailComposeViewController alloc] init];
    self.mailController.mailComposeDelegate = self;
    [self.mailController setSubject:subject];
    [self.mailController setToRecipients:recipients];

    self.parentViewController = parentViewController;
    [parentViewController presentViewController:self.mailController animated:YES completion:nil];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (BOOL)isVisible
{
    return [self.mailController isVisible];
}


//=== MFMailComposeViewControllerDelegate ===//
#pragma mark - MFMailComposeViewControllerDelegate

/*
 * (Inherited Comment)
 */
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    if (error != nil) {
        MKLogError(@"Error sending email: %@", [error localizedDescription]);
    }
    [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
