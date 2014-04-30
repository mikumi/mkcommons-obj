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

- (void)testIsLegacyPlatform {
    if (kCFCoreFoundationVersionNumber <= kCFCoreFoundationVersionNumber_iOS_6_1) {
        XCTAssertEqual(YES, [MKMiscHelper isLegacyPlatform], @"Should be able to identify legacy platforms < iOS 7.0");
    } else {
        XCTAssertEqual(NO, [MKMiscHelper isLegacyPlatform], @"Should be able to identify a modern platform >= IOS 7.0");
    }
}

- (void)testIsRunningOnPhone {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        XCTAssertEqual(YES, [MKMiscHelper isRunningOnPhone], @"Should return YES for running on a phone.");
    } else {
        XCTAssertEqual(NO, [MKMiscHelper isRunningOnPhone], @"Should return NO for running on a pad.");
    }
}

@end
