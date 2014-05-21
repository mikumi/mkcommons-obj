//
//  MKDateUtilsTest.m
//  MKCommons
//
//  Created by Michael Kuck on 5/19/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MKDateUtils.h"
#import "MKLog.h"

@interface MKDateUtilsTest : XCTestCase

- (NSString *)dateToString:(NSDate *)date;

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
    NSDate *const zeroDate = [MKDateUtils removeTimeComponentsFromDate:[NSDate date]];
    NSDate *const currentDate = [NSDate date];
    NSDate *const resultDate = [MKDateUtils dateByCopyingTimeComponentsFromDate:currentDate toDate:zeroDate];
    NSString *const expectedTimeString = [self dateToString:currentDate withDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
    NSString *const actualTimeString = [self dateToString:resultDate withDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
    MKLogVerbose(@"Date: %@", [self dateToString:zeroDate]);
    MKLogVerbose(@"Date: %@", [self dateToString:currentDate]);
    MKLogVerbose(@"Date: %@", [self dateToString:resultDate]);
    XCTAssert([expectedTimeString isEqualToString:actualTimeString], @"Time components were not correctly copied");
}

- (void)testDateByCopyingDateComponentsFromDate
{
    NSDate *const zeroDate = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *const currentDate = [NSDate date];
    NSDate *const resultDate = [MKDateUtils dateByCopyingDateComponentsFromDate:currentDate toDate:zeroDate];
    NSString *const expectedTimeString = [self dateToString:currentDate withDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    NSString *const actualTimeString = [self dateToString:resultDate withDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    MKLogVerbose(@"Date: %@", [self dateToString:zeroDate]);
    MKLogVerbose(@"Date: %@", [self dateToString:currentDate]);
    MKLogVerbose(@"Date: %@", [self dateToString:resultDate]);
    XCTAssert([expectedTimeString isEqualToString:actualTimeString], @"Time components were not correctly copied");
}

- (void)testRemoveTimeComponentsFromDate
{
    NSDate *const date = [NSDate date];
    MKLogVerbose(@"Date: %@", [self dateToString:date]);
    NSDate *const result = [MKDateUtils removeTimeComponentsFromDate:date];
    MKLogVerbose(@"Result: %@", [self dateToString:result]);
    NSString *const expectedResultString = @"12:00:00 AM";
    NSString *const actualResultString = [self dateToString:result withDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
    XCTAssert([expectedResultString isEqualToString:actualResultString], @"Time components were not removed corectly");
}

- (void)testDateByStrippingTimeZoneInformation
{
    NSDate *const now = [NSDate date];
    NSDate *const stripped = [MKDateUtils dateByStrippingTimeZoneFromDate:now];
    NSDate *const restored = [MKDateUtils dateBySettingTimeZoneForDate:stripped];
    MKLogVerbose(@"now: %@ (%@)", now, [self dateToString:now]);
    MKLogVerbose(@"stripped: %@ (%@)", stripped, [self dateToString:stripped]);
    MKLogVerbose(@"restored: %@ (%@)", restored, [self dateToString:restored]);
    // TODO: implement XCTAssert
}

- (NSString *)dateToString:(NSDate *)date
{
    return [self dateToString:date withDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)dateToString:(NSDate *)date
             withDateStyle:(NSDateFormatterStyle)dateStyle
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
