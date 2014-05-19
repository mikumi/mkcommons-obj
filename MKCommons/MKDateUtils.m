//
//  MKDateUtils.m
//  MKCommons
//
//  Created by Michael Kuck on 5/19/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKDateUtils.h"

@implementation MKDateUtils

/**
* // TODO: this method comment needs be updated.
*/
+ (NSDate *)dateByCopyingTimeComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSDate *result = [MKDateUtils removeTimeComponentsFromDate:toDate];

    NSUInteger const flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar       *const calendar   = [NSCalendar currentCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:fromDate];
    result = [calendar dateByAddingComponents:components toDate:result options:0];

    return result;
}

/**
* // TODO: this method comment needs be updated.
*/
+ (NSDate *)dateByCopyingDateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSDate *dateOnly = [MKDateUtils removeTimeComponentsFromDate:fromDate];

    NSUInteger const flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar       *const calendar   = [NSCalendar currentCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:toDate];
    NSDate *result = [calendar dateByAddingComponents:components toDate:dateOnly options:0];

    return result;
}

/**
* // TODO: this method comment needs be updated.
*/
+ (NSDate *)removeTimeComponentsFromDate:(NSDate *)date
{
    NSUInteger const flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSTimeZoneCalendarUnit;
    NSCalendar       *const calendar   = [NSCalendar currentCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:date];

    NSDate *result = [calendar dateFromComponents:components];

    return result;
}

@end
