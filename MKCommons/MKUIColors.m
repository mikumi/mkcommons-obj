//
//  MKUIColors.m
//  MKCommons
//
//  Created by Michael Kuck on 5/7/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKUIColors.h"

#import "MKLog.h"

@implementation MKUIColors

/*
 * (Inherited Comment)
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        MKLogError(@"MKUIColor is not meant to be instantiated.");
    }
    return self;
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (UIColor *)lightBlue
{
    UIColor *const color = [UIColor colorWithRed:(124.0f/255.0f)
                                           green:(198.0f/255.0f)
                                            blue:(247.0f/255.0f)
                                           alpha:1.0f];
    return color;
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (UIColor *)mediumBlue
{
    UIColor *const color = [UIColor colorWithRed:(62.0f/255.0f)
                                                green:(169.0f/255.0f)
                                                 blue:(240.0f/255.0f)
                                                alpha:1.0f];
    return color;
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (UIColor *)darkBlue
{
    UIColor *const color = [UIColor colorWithRed:(38.0f/255.0f)
                                                     green:(107.0f/255.0f)
                                                      blue:(153.0f/255.0f)
                                                     alpha:1.0f];
    return color;
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (UIColor *)veryLightGray
{
    UIColor *const color = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
    return color;
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (UIColor *)lightGray
{
    UIColor *const color = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.0f];
    return color;
}

@end
