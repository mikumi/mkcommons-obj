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
* Found out if running on an iPhone-like device (including iPod) or iPad
*
* @return YES if running on iPhone
*/
+ (BOOL)isRunningOnPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

/**
* // DOCU: this method comment needs be updated.
*/
+ (NSURL *)pathToDirectory:(MKSystemHelperPathType)pathType
{
    NSSearchPathDirectory const searchPathType = (NSSearchPathDirectory)pathType;
    NSURL *const directory = [[[NSFileManager defaultManager] URLsForDirectory:searchPathType inDomains:NSUserDomainMask] lastObject];
    return directory;
}

/**
* Returns the build number specified in the application bundle.
*
* @return NSUInteger containing the build number
*/
+ (NSUInteger)buildNumber
{
    NSUInteger const buildNumber = (NSUInteger)[[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
            integerValue];
    return buildNumber;
}

+ (NSString *)versionString
{
    NSString *const versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return versionString;
}



@end
