//
//  MKMiscHelperTest.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/22/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>

extern void __gcov_flush();

#import <UIKit/UIKit.h>

#import "MKSystemHelper.h"

@interface MKMiscHelperTest : XCTestCase

@end

@implementation MKMiscHelperTest

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

- (void)testIsRunningOnPhone
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        XCTAssertEqual(YES, [MKSystemHelper isRunningOnPhone], @"Should return YES for running on a phone.");
    } else {
        XCTAssertEqual(NO, [MKSystemHelper isRunningOnPhone], @"Should return NO for running on a pad.");
    }
}

@end
