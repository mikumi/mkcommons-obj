//
//  MKLogTest.m
//  MKCommons
//
//  Created by Michael Kuck on 9/30/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>
extern void __gcov_flush();

#import "MKLog.h"

@interface MKLogTest : XCTestCase

@end

@implementation MKLogTest

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

- (void)testLogTest
{
    MKSetLogLevel(MKLogLevelVerbose);
    MKLogError(@"This is an error message: %d", 1);
    MKLogWarning(@"This is a warning message: %d", 2);
    MKLogInfo(@"This is an info message: %d", 3);
    MKLogVerbose(@"This is a verbose message: %d", 4);
}

@end
