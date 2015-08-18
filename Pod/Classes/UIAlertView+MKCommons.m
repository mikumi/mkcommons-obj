//
// Created by Michael Kuck on 2/3/15.
// Copyright (c) 2015 Michael Kuck. All rights reserved.
//

#import <objc/runtime.h>
#import "UIAlertView+MKCommons.h"

static void * CompletionPropertyKey = &CompletionPropertyKey;

//============================================================
//== Private Interface
//============================================================
@interface UIAlertView () <UIAlertViewDelegate>



@end

//============================================================
//== Implementation
//============================================================
@implementation UIAlertView (MKCommons)

- (void)showWithCompletion:(MKAlertViewCompletion)completion
{
    self.delegate = self;
    self.completion = completion;
    [self show];
}

#pragma mark - Public Implementation

- (MKAlertViewCompletion)completion {
    return objc_getAssociatedObject(self, CompletionPropertyKey);
}

- (void)setCompletion:(MKAlertViewCompletion)unicorn {
    objc_setAssociatedObject(self, CompletionPropertyKey, unicorn, OBJC_ASSOCIATION_COPY);
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completion) {
        self.completion(buttonIndex);
    }
}


@end