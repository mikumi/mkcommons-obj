//
//  MKSerialManagerTest.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/13/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>
extern void __gcov_flush();

#import "MKSerialManager.h"

#import "MKCommons.h"

@interface MKSerialManagerTest : XCTestCase

@end

@implementation MKSerialManagerTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
#ifdef COVERAGE
    __gcov_flush();
#endif
    [super tearDown];
}

- (void)testGenerateSerial
{
    NSString *product = @"PM";
    NSInteger feature = 01;
    NSInteger expiryTime = 24 * 7;
    NSString *serial = [MKSerialManager generateSerialForProduct:product feature:feature expiryTime:expiryTime];
    MKLogInfo(@"Serial generated: %@", serial);

    NSString *expectedFront = product;
    NSString *actualFront = [serial substringToIndex:2];
    XCTAssertEqualObjects(expectedFront, actualFront, @"Serial product and version do not match.");
}

- (void)testVerifySerial
{
    NSString *product = @"PM";
    NSInteger feature = 01;
    NSInteger expiryTime = 24;
    NSString *serial = [MKSerialManager generateSerialForProduct:product feature:feature expiryTime:expiryTime];
    
    BOOL success = [MKSerialManager isSerialValid:serial forProduct:product forFeature:feature];
    XCTAssertEqual(YES, success, @"Serial should be ok.");
    
    
}

- (void)testExpiredSerial
{
    NSString *product = @"PM";
    NSInteger feature = 01;
    NSInteger expiryTime = -24;
    NSString *serial = [MKSerialManager generateSerialForProduct:product feature:feature expiryTime:expiryTime];
    
    BOOL success = [MKSerialManager isSerialValid:serial forProduct:product forFeature:feature];
    XCTAssertEqual(NO, success, @"Serial should have been expired.");
    
    
}

- (void)testInvalidSerial
{
    NSString *serial = @"PM1136-6278-5673-08569";
    BOOL success = [MKSerialManager isSerialValid:serial forProduct:@"PM" forFeature:01];
    XCTAssertEqual(NO, success, @"Serial should be invalid.!");
    
    serial = @"?";
    success = [MKSerialManager isSerialValid:serial forProduct:@"PM" forFeature:01];
    XCTAssertEqual(NO, success, @"Serial should be invalid.!");
}

- (void)testHasEnoughSerials
{
    NSUInteger atLeast = 50;
    
    NSMutableSet *serials = [[NSMutableSet alloc] init];
    NSInteger i = 1000;
    while ((i > 0) && ([serials count] < atLeast)) {
        NSString *serial = [MKSerialManager generateSerialForProduct:@"PM" feature:01 expiryTime:24];
        if (![serials containsObject:serial]) {
            [serials addObject:serial];
        }
        if ((i % 10) == 0) {
            MKLogVerbose(@"%lu serials found. continue searching...", (unsigned long)[serials count]);
        }
        i--;
    }
    XCTAssert([serials count] >= atLeast, @"Not enough serials found: %lu. Should be at least %lu.", (unsigned long)[serials count], (unsigned long)atLeast);
}

@end
