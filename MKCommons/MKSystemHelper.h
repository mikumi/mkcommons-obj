//
//  MKSystemHelper.h
//  MKCommons
//
//  Created by Michael Kuck on 6/27/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MKSystemHelperPathType) {
    MKPathTypeDocuments = NSDocumentDirectory, MKPathTypeLibrary = NSLibraryDirectory, MKPathTypeCache = NSCachesDirectory
};

/**
 * Miscellaneous helpers for everything and anything
 */
@interface MKSystemHelper : NSObject

+ (BOOL)isLegacyPlatform;
+ (BOOL)isRunningOnPhone;
+ (NSString *)pathToDirectory:(MKSystemHelperPathType)pathType;

@end
