//
//  MKSystemHelper.m
//  MKCommons
//
//  Created by Michael Kuck on 6/27/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKSystemHelper.h"
#import "MKLog.h"

#import <UIKit/UIKit.h>

static NSUInteger const NetworkIndicatorTimeout = 30.0f;

static NSUInteger     networkActivityIndicatorShowCounter = 0;
static NSTimer        *networkIndicatorTimer              = nil;
static NSTimeInterval networkIndicatorTimeLeft            = 0;

//============================================================
//== Private Interface
//============================================================
@interface MKSystemHelper ()

+ (void)networkIndicatorTimerEvent:(id)sender;

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
    NSSearchPathDirectory const searchPathType   = (NSSearchPathDirectory)pathType;
    NSArray                     *paths           = NSSearchPathForDirectoriesInDomains(searchPathType,
                                                                                       NSUserDomainMask, YES);
    NSString                    *path            = [paths objectAtIndex:0];
    BOOL                        isDirectoryExist = NO;
    NSError                     *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectoryExist] && (!isDirectoryExist)) {
        [[NSFileManager defaultManager]
                createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    }
    return path;
}

/**
* Show or hide the statusbar network activity indicator. Will use internal counter to allow setting/hiding it in
* multiple locations at the same time. If the couter is positive, indicator will be shown, if the counter is negative,
* indicator will be hidden.
*
*
* @param isVisible YES if indicator should be shown, NO if hidden
*/
+ (void)showNetworkActivityIndicator:(BOOL)isVisible
{
    @synchronized(self) {
        networkIndicatorTimeLeft = NetworkIndicatorTimeout;
        if (isVisible) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            networkIndicatorTimeLeft = NetworkIndicatorTimeout;
            if (networkIndicatorTimer == nil) {
                networkIndicatorTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                                                       selector:@selector(networkIndicatorTimerEvent:)
                                                                       userInfo:nil repeats:YES];
            }
        } else {
            if (networkActivityIndicatorShowCounter > 0) {
                networkActivityIndicatorShowCounter--;
            }
            if (networkActivityIndicatorShowCounter <= 0) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [networkIndicatorTimer invalidate];
                networkIndicatorTimer = nil;
            }
        }
    }
}

/**
* // TODO: this method comment needs be updated.
*/
+ (void)networkIndicatorTimerEvent:(id)sender
{
    @synchronized(self) {
        networkIndicatorTimeLeft -= 1.0f;
        if (networkIndicatorTimeLeft <= 0) {
            networkActivityIndicatorShowCounter = 1;
            [self showNetworkActivityIndicator:NO];
            MKLogDebug(@"Disabling network indicator as of timeout...")
        }
    }
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)showBigNetworkActivityIndicator:(BOOL)isVisible
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect   frame      = keyWindow.frame;
    CGFloat  viewWidth  = 100;
    CGFloat  viewHeight = 100;
    frame.origin.x    = frame.size.width / 2 - viewWidth / 2;
    frame.origin.y    = frame.size.height / 2 - viewHeight / 2;
    frame.size.width  = viewWidth;
    frame.size.height = viewHeight;

    // Main View
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.cornerRadius  = 10.0f;
    view.layer.masksToBounds = YES;

    // Indicator view
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]
            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.frame = CGRectMake(35.0, 25.0, 30.0, 30.0);

    // Loading label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 75.0, 80.0, 15.0)];
    label.backgroundColor = [UIColor clearColor];
    label.font            = [UIFont boldSystemFontOfSize:13.0];
    label.textColor       = [UIColor whiteColor];
    label.text            = @"Loading";
    label.textAlignment   = UITextAlignmentCenter;

    [view addSubview:indicatorView];
    [view addSubview:label];
    [indicatorView startAnimating];
    [keyWindow addSubview:view];
}

@end
