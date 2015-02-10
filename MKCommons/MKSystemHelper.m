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
