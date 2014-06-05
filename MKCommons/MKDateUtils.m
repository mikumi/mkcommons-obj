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
    NSDate *result = [MKDateUtils dateByRemovingTimeComponentsFromDate:toDate];

    NSCalendarUnit const flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar       *const calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:fromDate];
    result = [calendar dateByAddingComponents:components toDate:result options:0];

    return result;
}

/**
* // TODO: this method comment needs be updated.
*/
+ (NSDate *)dateByCopyingDateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSDate *const dateOnly = [MKDateUtils dateByRemovingTimeComponentsFromDate:fromDate];

    NSCalendarUnit const flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar       *const calendar   = [NSCalendar currentCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:toDate];
    NSDate           *const result     = [calendar dateByAddingComponents:components toDate:dateOnly options:0];

    return result;
}

/**
* Convert an NSDate in the current timezone to an NSDate that will display the same time in GMT-0. E.g. 8PM in GMT+8
* will now be 8PM in GMT-0.
*
* @param date The date that the timezone information should be stripped from.
*
* @return The same time in GMT-0
*/
+ (NSDate *)dateByStrippingTimeZoneFromDate:(NSDate *)date
{
    NSTimeInterval const timeDifferenceSeconds = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    NSDate *const result = [date dateByAddingTimeInterval:timeDifferenceSeconds];
    return result;
}

/**
* Set the timezone for a timezone-less NSDate (for example removed by dateByStrippingTimeZoneFromDate:). It is assumed
* that the date is in GMT-0. After setting the time zone, it will display the same time in the current time zone.
* Example: 8PM in GMT-0 will now display 8PM in the current time zone.
*
* @param date An NSDate in GMT-0.
*
* @return comment
*/
+ (NSDate *)dateBySettingTimeZoneForDate:(NSDate *)date
{
    NSTimeInterval const timeDifferenceSeconds = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    NSDate *const result = [date dateByAddingTimeInterval:(-timeDifferenceSeconds)];
    return result;
}

/**
* // TODO: this method comment needs be updated.
*/
+ (NSDate *)dateByRemovingTimeComponentsFromDate:(NSDate *)date
{
    NSCalendarUnit const flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSTimeZoneCalendarUnit;
    NSCalendar       *const calendar   = [NSCalendar currentCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:date];

    NSDate           *const result     = [calendar dateFromComponents:components];
    return result;
}

/**
* // TODO: this method comment needs be updated.
*/
+ (NSString *)stringFromDate:(NSDate *)date dateStyle:(NSDateFormatterStyle)dateStyle
                   timeStyle:(NSDateFormatterStyle)timeStyle
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];

    });
    @synchronized(dateFormatter) {
        dateFormatter.dateStyle = dateStyle;
        dateFormatter.timeStyle = timeStyle;
        return [dateFormatter stringFromDate:date];
    }
}

/**
* // TODO: this method comment needs be updated.
*/
+ (NSString *)stringFromDate:(NSDate *)date timeZone:(NSTimeZone *)timeZone dateStyle:(NSDateFormatterStyle)dateStyle
                   timeStyle:(NSDateFormatterStyle)timeStyle
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];

    });
    @synchronized(dateFormatter) {
        dateFormatter.dateStyle = dateStyle;
        dateFormatter.timeStyle = timeStyle;
        dateFormatter.timeZone  = timeZone;
        return [dateFormatter stringFromDate:date];
    }
}

/**
* // TODO: this method comment needs be updated.
*/
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];

    });
    @synchronized(dateFormatter) {
        dateFormatter.dateFormat = format;
        return [dateFormatter stringFromDate:date];
    }
}

/**
* // TODO: this method comment needs be updated.
*/
+ (NSString *)stringFromDate:(NSDate *)date
{
    return [self stringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
}

/**
* // TODO: this method comment needs be updated.
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
