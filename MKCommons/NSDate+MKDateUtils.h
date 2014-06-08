//
//  NSDate+MKDateUtils.h
//  MKCommons
//
//  Created by Michael Kuck on 6/8/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MKDateUtils)

- (NSDate *)dateByMatchingTimeComponentsFromDate:(NSDate *)date;
- (NSDate *)dateByMatchingDateComponentsFromDate:(NSDate *)date;
- (NSDate *)dateByStrippingTimeZone;
- (NSDate *)dateBySettingTimeZone;
- (NSDate *)dateByRemovingTimeComponents;
- (NSDate *)dateByRemovingSeconds;
- (NSString *)stringFromDateWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)stringFromDateWithTimeZone:(NSTimeZone *)timeZone dateStyle:(NSDateFormatterStyle)dateStyle
                               timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)stringFromDateWithFormat:(NSString *)format;
- (NSString *)stringFromDate;

@end
