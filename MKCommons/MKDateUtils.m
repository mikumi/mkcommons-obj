//
//  MKDateUtils.m
//  MKCommons
//
//  Created by Michael Kuck on 5/19/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKDateUtils.h"
#import "MKLog.h"

@implementation MKDateUtils

/**
* // TODO: this method comment needs be updated.
*/
+ (NSDate *)dateByCopyingTimeComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSDate *result = [MKDateUtils removeTimeComponentsFromDate:toDate];

    NSUInteger const flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
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
+ (NSDate *)dateByStrippingTimezoneFromDate:(NSDate *)date
{
//    NSUInteger const flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit |
//    NSCalendar       *const calendar   = [NSCalendar currentCalendar];
//    NSDateComponents *const components = [calendar components:flags fromDate:toDate];
//    NSDate *result = [calendar dateByAddingComponents:components toDate:dateOnly options:0];
//
//    return result;
    MKLogError(@"Not implemented yet");
    assert(NO);
    return nil;
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
        dateFormatter.timeZone = timeZone;
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
    static NSTimeZone *timeZone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    });
    return timeZone;
}

@end
