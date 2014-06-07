//
//  MKSystemHelper.m
//  MKCommons
//
//  Created by Michael Kuck on 6/27/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKSystemHelper.h"
#import "MKLog.h"

//============================================================
//== Private Interface
//============================================================
@interface MKSystemHelper ()

@end

//============================================================
//== Implementation
//============================================================
@implementation MKSystemHelper

/**
* Find out if the current platform is running iOS 7.0 or anything below.
*
*
* @return True if < 7.0, false if >= 7.0.
*/
+ (BOOL)isLegacyPlatform
{
    BOOL iOS6OrLess = kCFCoreFoundationVersionNumber <= kCFCoreFoundationVersionNumber_iOS_6_1;
    return iOS6OrLess;
}

/**
* Found out if running on an iPhone-like device (including iPod) or iPad
*
* @return YES if running on iPhone
*/
+ (BOOL)isRunningOnPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

/**
* // TODO: this method comment needs be updated.
*/
+ (NSString *)pathToDirectory:(MKSystemHelperPathType)pathType
{
    NSSearchPathDirectory const searchPathType = (NSSearchPathDirectory)pathType;

    NSArray  *const paths = NSSearchPathForDirectoriesInDomains(searchPathType, NSUserDomainMask, YES);
    NSString *const path  = paths[0];
    BOOL    isDirectoryExist = NO;
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectoryExist] && (!isDirectoryExist)) {
        [[NSFileManager defaultManager]
                createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    }
    return path;
}

/**
* // TODO: this method comment needs be updated.
*/
+ (void)showBigNetworkActivityIndicator:(BOOL)isVisible
{
    // Setup Frame
    UIWindow *const keyWindow = [UIApplication sharedApplication].keyWindow;
    CGFloat const viewWidth      = 100;
    CGFloat const viewHeight     = 100;
    CGRect        indicatorFrame = keyWindow.frame;
    indicatorFrame.origin.x    = indicatorFrame.size.width / 2 - viewWidth / 2;
    indicatorFrame.origin.y    = indicatorFrame.size.height / 2 - viewHeight / 2;
    indicatorFrame.size.width  = viewWidth;
    indicatorFrame.size.height = viewHeight;

    // Indicator view container
    UIView *const view = [[UIView alloc] initWithFrame:indicatorFrame];
    view.layer.cornerRadius  = 10.0f;
    view.layer.masksToBounds = YES;

    // Indicator view
    UIActivityIndicatorView *const indicatorView = [[UIActivityIndicatorView alloc]
            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.frame = CGRectMake(35.0, 25.0, 30.0, 30.0);

    // Loading label
    UILabel *const label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 75.0, 80.0, 15.0)];
    label.backgroundColor = [UIColor clearColor];
    label.font            = [UIFont boldSystemFontOfSize:13.0];
    label.textColor       = [UIColor whiteColor];
    label.text            = @"Loading";
    label.textAlignment   = NSTextAlignmentCenter;

    // Combine everything
    [view addSubview:indicatorView];
    [view addSubview:label];
    [indicatorView startAnimating];
    [keyWindow addSubview:view];
}

//=== Private Implementation ===//
#pragma mark - Private Implementation

@end
