//
//  MKFallbackQueueTest.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/25/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>

extern void __gcov_flush();

#import "MKFallbackQueue.h"

@interface MKFallbackQueueTest : XCTestCase

@end

@implementation MKFallbackQueueTest

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

- (void)testInitWithNil
{
    MKFallbackQueue *fallbackQueue = [[MKFallbackQueue alloc] init];
    XCTAssertEqualObjects(nil, [fallbackQueue topObject], @"Empty queue should always return nil");
    XCTAssertEqualObjects(nil, [fallbackQueue moveTopObjectToBottomAndGetNextOne], @"Empty queue should always return nil");
}

- (void)testTopObject
{
    NSString *test1 = @"Test1";
    NSString *test2 = @"Test2";
    MKFallbackQueue *fallbackQueue = [[MKFallbackQueue alloc] initWithObjects:@[test1, test2]];

    XCTAssertEqualObjects(test1, [fallbackQueue topObject], @"Top item should be test1");
}

- (void)testMoveTopObjectToBottomAndGetNextOne
{
    NSString *test1 = @"Test1";
    NSString *test2 = @"Test2";
    MKFallbackQueue *fallbackQueue = [[MKFallbackQueue alloc] initWithObjects:@[test1, test2]];

    XCTAssertEqualObjects(test2, [fallbackQueue moveTopObjectToBottomAndGetNextOne], @"Second item should be test2");
    XCTAssertEqualObjects(test2, [fallbackQueue topObject], @"Top item should now be test2");
    XCTAssertEqualObjects(test1, [fallbackQueue moveTopObjectToBottomAndGetNextOne], @"Top item should now be test1 again");
}

@end
