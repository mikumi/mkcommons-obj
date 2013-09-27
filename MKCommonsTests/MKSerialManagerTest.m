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

@interface MKSerialManagerTest : XCTestCase

@property (nonatomic, strong) MKSerialManager *serialManager;

@end

@implementation MKSerialManagerTest

- (void)setUp
{
    [super setUp];
    self.serialManager = [[MKSerialManager alloc] init];
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
    NSString *serial = [self.serialManager generateSerialForProduct:product andFeature:feature withExpiryTime:expiryTime];
    NSLog(@"Serial generated: %@", serial);

    NSString *expectedFront = product;
    NSString *actualFront = [serial substringToIndex:2];
    XCTAssertEqualObjects(expectedFront, actualFront, @"Serial product and version do not match.");
}

- (void)testVerifySerial
{
    NSString *product = @"PM";
    NSInteger feature = 01;
    NSInteger expiryTime = 24;
    NSString *serial = [self.serialManager generateSerialForProduct:product andFeature:feature withExpiryTime:expiryTime];
    
    BOOL success = [self.serialManager isSerialValid:serial forProduct:product forFeature:feature];
    XCTAssertEqual(YES, success, @"Serial should be ok.");
    
    
}

- (void)testExpiredSerial
{
    NSString *product = @"PM";
    NSInteger feature = 01;
    NSInteger expiryTime = -24;
    NSString *serial = [self.serialManager generateSerialForProduct:product andFeature:feature withExpiryTime:expiryTime];
    
    BOOL success = [self.serialManager isSerialValid:serial forProduct:product forFeature:feature];
    XCTAssertEqual(NO, success, @"Serial should have been expired.");
    
    
}

- (void)testInvalidSerial
{
    NSString *serial = @"PM1136-6278-5673-08569";
    BOOL success = [self.serialManager isSerialValid:serial forProduct:@"PM" forFeature:01];
    XCTAssertEqual(NO, success, @"Serial should be invalid.!");
    
    serial = @"?";
    success = [self.serialManager isSerialValid:serial forProduct:@"PM" forFeature:01];
    XCTAssertEqual(NO, success, @"Serial should be invalid.!");
}

- (void)testHasEnoughSerials
{
    NSUInteger atLeast = 50;
    
    NSMutableSet *serials = [[NSMutableSet alloc] init];
    NSInteger i = 1000;
    while ((i > 0) && ([serials count] < atLeast)) {
        NSString *serial = [self.serialManager generateSerialForProduct:@"PM" andFeature:01 withExpiryTime:24];
        if (![serials containsObject:serial]) {
            [serials addObject:serial];
        }
        if ((i % 10) == 0) {
            NSLog(@"%d serials found. continue searching...", [serials count]);
        }
//        NSLog(@"serial found: %@", serial);
        i--;
    }
    XCTAssert([serials count] >= atLeast, @"Not enough serials found: %d. Should be at least %d.", [serials count], atLeast);
}

@end
