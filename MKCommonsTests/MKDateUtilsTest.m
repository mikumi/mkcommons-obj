//
//  MKDateUtilsTest.m
//  MKCommons
//
//  Created by Michael Kuck on 5/19/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+MKDateUtils.h"
#import "MKLog.h"

@interface MKDateUtilsTest : XCTestCase

- (NSString *)dateToString:(NSDate *)date;
- (NSString *)dateToString:(NSDate *)date withDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

@end

@implementation MKDateUtilsTest

- (void)setUp
{
    [super setUp];
    MKSetLogLevel(MKLogLevelVerbose);
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDateByCopyingTimeComponentsFromDate
{
    NSDate   *const zeroDate           = [[NSDate date] dateByRemovingTimeComponents];
    NSDate   *const currentDate        = [NSDate date];
    NSDate   *const resultDate         = [zeroDate dateByMatchingTimeComponentsFromDate:currentDate];
    NSString *const expectedTimeString = [self dateToString:currentDate withDateStyle:NSDateFormatterNoStyle
                                                  timeStyle:NSDateFormatterMediumStyle];
    NSString *const actualTimeString   = [self dateToString:resultDate withDateStyle:NSDateFormatterNoStyle
                                                  timeStyle:NSDateFormatterMediumStyle];
    MKLogVerbose(@"Date: %@", [self dateToString:zeroDate]);
    MKLogVerbose(@"Date: %@", [self dateToString:currentDate]);
    MKLogVerbose(@"Date: %@", [self dateToString:resultDate]);
    XCTAssert([expectedTimeString isEqualToString:actualTimeString], @"Time components were not correctly copied");
}

- (void)testDateByCopyingDateComponentsFromDate
{
    NSDate   *const zeroDate           = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate   *const currentDate        = [NSDate date];
    NSDate   *const resultDate         = [zeroDate dateByMatchingDateComponentsFromDate:currentDate];
    NSString *const expectedTimeString = [self dateToString:currentDate withDateStyle:NSDateFormatterShortStyle
                                                  timeStyle:NSDateFormatterNoStyle];
    NSString *const actualTimeString   = [self dateToString:resultDate withDateStyle:NSDateFormatterShortStyle
                                                  timeStyle:NSDateFormatterNoStyle];
    MKLogVerbose(@"Date: %@", [self dateToString:zeroDate]);
    MKLogVerbose(@"Date: %@", [self dateToString:currentDate]);
    MKLogVerbose(@"Date: %@", [self dateToString:resultDate]);
    XCTAssert([expectedTimeString isEqualToString:actualTimeString], @"Time components were not correctly copied");
}

- (void)testRemoveTimeComponentsFromDate
{
    NSDate *const date = [NSDate date];
    MKLogVerbose(@"Date: %@", [self dateToString:date]);
    NSDate *const result = [date dateByRemovingTimeComponents];
    MKLogVerbose(@"Result: %@", [self dateToString:result]);
    NSString *const expectedResultString = @"12:00:00 AM";
    NSString *const actualResultString   = [self dateToString:result withDateStyle:NSDateFormatterNoStyle
                                                    timeStyle:NSDateFormatterMediumStyle];
    XCTAssert([expectedResultString isEqualToString:actualResultString], @"Time components were not removed corectly");
}

- (void)testDateByStrippingTimeZoneInformation
{
    NSDate *const now      = [NSDate date];
    NSDate *const stripped = [now dateByStrippingTimeZone];
    NSDate *const restored = [stripped dateBySettingTimeZone];
    MKLogVerbose(@"now: %@ (%@)", now, [self dateToString:now]);
    MKLogVerbose(@"stripped: %@ (%@)", stripped, [self dateToString:stripped]);
    MKLogVerbose(@"restored: %@ (%@)", restored, [self dateToString:restored]);
    // TODO: implement XCTAssert
}

- (void)testTimeDifferenceInDaysToDate
{
    NSDate *const now      = [NSDate date];
    NSDate *const tomorrow = [now dateByAddingTimeInterval:(24 * 60 * 60)];
    XCTAssert([now timeDifferenceInDaysToDate:now] == 0, @"");
    XCTAssert([now timeDifferenceInDaysToDate:tomorrow] == 1, @"");
    XCTAssert([tomorrow timeDifferenceInDaysToDate:now] == -1, @"");
}

- (void)testDateFromString
{
    NSString *const testString1 = @"2014-01-02T03:04:05.006";
    NSString *const testFormat1 = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    NSDate *const testDate = [NSDate dateFromString:testString1 format:testFormat1];
    XCTAssertEqual(testDate.year, 2014, @"Year did not match");
    XCTAssertEqual(testDate.month, 1, @"Year did not match");
    XCTAssertEqual(testDate.day, 2, @"Year did not match");
    XCTAssertEqual(testDate.hour, 3, @"Year did not match");
    XCTAssertEqual(testDate.minute, 4, @"Year did not match");
    XCTAssertEqual(testDate.second, 5, @"Year did not match");
}

//=== Private Implementation ===//
#pragma mark - Private Implementation

- (NSString *)dateToString:(NSDate *)date
{
    return [self dateToString:date withDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)dateToString:(NSDate *)date withDateStyle:(NSDateFormatterStyle)dateStyle
                 timeStyle:(NSDateFormatterStyle)timeStyle;
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    [dateFormatter setDateStyle:dateStyle];
    [dateFormatter setTimeStyle:timeStyle];
    return [dateFormatter stringFromDate:date];
}


@end
