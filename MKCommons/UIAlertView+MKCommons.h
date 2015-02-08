//
// Created by Michael Kuck on 2/3/15.
// Copyright (c) 2015 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MKAlertViewCompletion)(NSInteger buttonIndex);

@interface UIAlertView (MKCommons)

- (void)showWithCompletion:(MKAlertViewCompletion)completion;

@end