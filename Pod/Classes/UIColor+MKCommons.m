//
//  UIColor+MKCommons.m
//  MKCommons
//
//  Created by Michael Kuck on 5/30/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "UIColor+MKCommons.h"

@implementation UIColor (MKCommons)

/**
 * // DOCU: this method comment needs be updated.
 */
+ (UIColor *)lightBlue
{
    UIColor *const color = [UIColor colorWithRed:(124.0f / 255.0f) green:(198.0f / 255.0f) blue:(247.0f / 255.0f)
                                           alpha:1.0f];
    return color;
}

/**
 * // DOCU: this method comment needs be updated.
 */
+ (UIColor *)mediumBlue
{
    UIColor *const color = [UIColor colorWithRed:(62.0f / 255.0f) green:(169.0f / 255.0f) blue:(240.0f / 255.0f)
                                           alpha:1.0f];
    return color;
}

/**
 * // DOCU: this method comment needs be updated.
 */
+ (UIColor *)darkBlue
{
    UIColor *const color = [UIColor colorWithRed:(38.0f / 255.0f) green:(107.0f / 255.0f) blue:(153.0f / 255.0f)
                                           alpha:1.0f];
    return color;
}

/**
 * // DOCU: this method comment needs be updated.
 */
+ (UIColor *)mediumRed
{
    UIColor *const color = [UIColor colorWithRed:(240.0f / 255.0f) green:(62.0f / 255.0f) blue:(62.0f / 255.0f)
                                           alpha:1.0f];
    return color;
}

/**
 * // DOCU: this method comment needs be updated.
 */
+ (UIColor *)veryLightGray
{
    UIColor *const color = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
    return color;
}

/**
 * // DOCU: this method comment needs be updated.
 */
+ (UIColor *)veryVeryLightGray
{
    UIColor *const color = [UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.0f];
    return color;
}

/**
 * // DOCU: this method comment needs be updated.
 */
+ (UIColor *)lightGray
{
    UIColor *const color = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.0f];
    return color;
}

+ (UIColor *)mediumGray
{
    UIColor *const color = [UIColor colorWithRed:0.70f green:0.70f blue:0.70f alpha:1.0f];
    return color;
}

@end
