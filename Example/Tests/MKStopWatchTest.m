//
//  MKStopWatchTest.m
//  MKCommons
//
//  Created by Michael Kuck on 10/2/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>

extern void __gcov_flush();

#import "MKStopwatch.h"

@interface MKStopWatchTest : XCTestCase

@end

@implementation MKStopWatchTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
#ifdef COVERAGE
    __gcov_flush();
#endif
    [super tearDown];
}

- (void)testInitial
{
    MKStopwatch *stopwatch = [[MKStopwatch alloc] init];
    XCTAssert([stopwatch timeDifference] == 0.0f, @"In the beginning time difference should be 0");
}

- (void)testStartStop
{
    MKStopwatch *stopwatch = [[MKStopwatch alloc] init];

    [stopwatch start];
    [NSThread sleepForTimeInterval:0.5f];
    XCTAssert([stopwatch timeDifference] == 0.0f, @"Time difference won't change until stopped.");
    [NSThread sleepForTimeInterval:0.5f];
    [stopwatch stop];
    XCTAssert([stopwatch timeDifference] >= 0.6f, @"Stopwatch should have been running for at least 1s");
}

@end
