//
//  NSTimeZone+MKDateUtils.m
//  MKCommons
//
//  Created by Michael Kuck on 6/8/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "NSTimeZone+MKDateUtils.h"

@implementation NSTimeZone (MKDateUtils)

/**
* // DOCU: this method comment needs be updated.
*/
+ (NSTimeZone *)noTimeZone
{
    static NSTimeZone      *timeZone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    });
    return timeZone;
}

@end
