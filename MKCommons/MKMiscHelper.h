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

/**
 * Get the index of a string in an array
 *
 * @param string The string to be found
 * @param array The array to be looked in
 * @return The index of the string
 */
+ (NSInteger)positionOfString:(NSString *)string inArray:(NSArray *)array;

/**
 * Find out if the current platform is running iOS 7.0 or anything below.
 *
 * @return True if < 7.0, false if >= 7.0.
 */
+ (BOOL)isLegacyPlatform;

#define executeBlock(block, ...) \
        do { \
            if (block) \
                block(__VA_ARGS__); \
                block = nil; \
        } while(0) /*semicolon omitted*/

@end
