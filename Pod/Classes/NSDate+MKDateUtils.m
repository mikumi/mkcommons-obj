//
//  NSDate+MKDateUtils.m
//  MKCommons
//
//  Created by Michael Kuck on 6/8/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "NSDate+MKDateUtils.h"

@implementation NSDate (MKDateUtils)

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)dateFormat
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    [dateFormatter setDateFormat:dateFormat];
    NSDate *const date = [dateFormatter dateFromString:dateString];
    return date;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSDate *)dateByMatchingTimeComponentsFromDate:(NSDate *)date
{
    NSDate *result = [self dateByRemovingTimeComponents];

    static NSCalendarUnit const flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar       *const calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:date];
    result = [calendar dateByAddingComponents:components toDate:result options:0];

    return result;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSDate *)dateByMatchingDateComponentsFromDate:(NSDate *)date
{
    NSDate *const dateOnly = [date dateByRemovingTimeComponents];

    static NSCalendarUnit const flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar       *const calendar   = [NSCalendar currentCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:self];
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
- (NSDate *)dateByStrippingTimeZone
{
    NSTimeInterval const timeDifferenceSeconds = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    NSDate *const result = [self dateByAddingTimeInterval:timeDifferenceSeconds];
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
- (NSDate *)dateBySettingTimeZone
{
    NSTimeInterval const timeDifferenceSeconds = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    NSDate *const result = [self dateByAddingTimeInterval:(-timeDifferenceSeconds)];
    return result;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSDate *)dateBySettingTimeZone:(NSTimeZone *)timeZone
{
    NSTimeInterval const timeDifferenceSeconds = [timeZone secondsFromGMT];
    NSDate *const result = [self dateByAddingTimeInterval:(-timeDifferenceSeconds)];
    return result;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSDate *)dateByRemovingTimeComponents
{
    static NSCalendarUnit const flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
                                        NSTimeZoneCalendarUnit;
    NSCalendar       *const calendar   = [NSCalendar currentCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:self];

    NSDate *const result = [calendar dateFromComponents:components];
    return result;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSDate *)dateByRemovingSeconds
{
    static NSCalendarUnit const flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
                                        NSTimeZoneCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSCalendar       *const calendar   = [NSCalendar currentCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:self];

    NSDate *const result = [calendar dateFromComponents:components];
    return result;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSString *)stringFromDateWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];

    });
    @synchronized(dateFormatter) {
        dateFormatter.dateStyle = dateStyle;
        dateFormatter.timeStyle = timeStyle;
        return [dateFormatter stringFromDate:self];
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSString *)stringFromDateWithTimeZone:(NSTimeZone *)timeZone dateStyle:(NSDateFormatterStyle)dateStyle
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
        return [dateFormatter stringFromDate:self];
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSString *)stringFromDateWithFormat:(NSString *)format
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];

    });
    @synchronized(dateFormatter) {
        dateFormatter.dateFormat = format;
        return [dateFormatter stringFromDate:self];
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSString *)stringFromDate
{
    return [self stringFromDateWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (BOOL)isBeforeDate:(NSDate *)date
{
    if ([self compare:date] == NSOrderedAscending) {
        return true;
    } else {
        return false;
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (BOOL)isAfterDate:(NSDate *)date
{
    if ([self compare:date] == NSOrderedDescending) {
        return true;
    } else {
        return false;
    }
}

/**
* Positive if date is after receiver, negative if it's before. 0 if no difference in days
*/
- (NSInteger)timeDifferenceInDaysToDate:(NSDate *)date
{
    static NSCalendarUnit const flags = NSDayCalendarUnit;
    NSCalendar       *const calendar         = [NSCalendar currentCalendar];
    NSDateComponents *const firstComponents  = [calendar components:flags fromDate:self];
    NSDateComponents *const secondComponents = [calendar components:flags fromDate:date];

    NSInteger difference = secondComponents.day - firstComponents.day;
    return difference;
}

- (NSInteger)year
{
    static NSCalendarUnit const flags = NSYearCalendarUnit;
    NSCalendar       *const calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:self];
    return components.year;
}

- (NSInteger)month
{
    static NSCalendarUnit const flags = NSMonthCalendarUnit;
    NSCalendar       *const calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:self];
    return components.month;
}

- (NSInteger)day
{
    static NSCalendarUnit const flags = NSDayCalendarUnit;
    NSCalendar       *const calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:self];
    return components.day;
}

- (NSInteger)hour
{
    static NSCalendarUnit const flags = NSHourCalendarUnit;
    NSCalendar       *const calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:self];
    return components.hour;
}

- (NSInteger)minute
{
    static NSCalendarUnit const flags = NSMinuteCalendarUnit;
    NSCalendar       *const calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:self];
    return components.minute;
}

- (NSInteger)second
{
    static NSCalendarUnit const flags = NSSecondCalendarUnit;
    NSCalendar       *const calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *const components = [calendar components:flags fromDate:self];
    return components.second;
}

@end
