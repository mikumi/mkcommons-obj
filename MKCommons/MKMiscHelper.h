//
//  MKMiscHelper.h
//  Ping Monitor
//
//  Created by Michael Kuck on 6/27/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Miscellaneous helpers for everything and anything
 */
@interface MKMiscHelper : NSObject

+ (BOOL)isLegacyPlatform;

+ (BOOL)isRunningOnPhone;

@end
