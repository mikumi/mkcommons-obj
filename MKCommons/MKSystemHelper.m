//
//  MKSystemHelper.m
//  MKCommons
//
//  Created by Michael Kuck on 6/27/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKSystemHelper.h"

#import <UIKit/UIKit.h>

@implementation MKSystemHelper

/**
 * Find out if the current platform is running iOS 7.0 or anything below.
 *
 * @return True if < 7.0, false if >= 7.0.
 */
+ (BOOL)isLegacyPlatform {
    BOOL iOS6OrLess = kCFCoreFoundationVersionNumber <= kCFCoreFoundationVersionNumber_iOS_6_1;
    if (iOS6OrLess) {
        return YES;
    } else {
        return NO;
    }
}

/**
 * Found out if running on an iPhone-like device (including iPod) or iPad
 *
 * @return YES if running on iPhone
 */
+ (BOOL)isRunningOnPhone {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (NSString *)pathToDirectory:(MKSystemHelperPathType)pathType
{
    NSSearchPathDirectory const searchPathType = (NSSearchPathDirectory)pathType;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathType, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    BOOL isDir = NO;
    NSError *error;
    if (! [[NSFileManager defaultManager] fileExistsAtPath:path
                                               isDirectory:&isDir] && isDir == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
    }
    return path;
}


@end
