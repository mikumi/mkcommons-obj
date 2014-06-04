//
//  MKDateUtils.h
//  MKCommons
//
//  Created by Michael Kuck on 5/19/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKDateUtils : NSObject

+ (NSDate *)dateByCopyingTimeComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSDate *)dateByCopyingDateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSDate *)dateByStrippingTimeZoneFromDate:(NSDate *)date;
+ (NSDate *)dateBySettingTimeZoneForDate:(NSDate *)date;
+ (NSDate *)dateByRemovingTimeComponentsFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date dateStyle:(NSDateFormatterStyle)dateStyle
                   timeStyle:(NSDateFormatterStyle)timeStyle;
+ (NSString *)stringFromDate:(NSDate *)date timeZone:(NSTimeZone *)timeZone dateStyle:(NSDateFormatterStyle)dateStyle
                                                                            timeStyle:(NSDateFormatterStyle)timeStyle;
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSTimeZone *)noTimeZone;

@end
