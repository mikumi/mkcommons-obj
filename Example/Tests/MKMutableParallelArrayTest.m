//
//  MKMutableParallelArrayTest.m
//  MKCommons
//
//  Created by Michael Kuck on 6/3/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MKMutableParallelArray.h"

@interface MKMutableParallelArrayTest : XCTestCase

@end

@implementation MKMutableParallelArrayTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectAtIndex
{
    MKMutableParallelArray *mutableParallelArray = [[MKMutableParallelArray alloc] init];
    NSString               *object0              = @"Object1";
    NSString               *object1              = @"Object1";
    [mutableParallelArray addObject:object0];
    [mutableParallelArray addObject:object1];
    XCTAssertTrue([mutableParallelArray objectAtIndex:0] == object0, "Index 0 should be object0");
    XCTAssertTrue([mutableParallelArray objectAtIndex:1] == object1, "Index 1 should be object1");
}

- (void)testRemoveObject
{
    MKMutableParallelArray *mutableParallelArray = [[MKMutableParallelArray alloc] init];
    NSString               *object0              = @"Object1";
    NSString               *object1              = @"Object1";
    [mutableParallelArray addObject:object0];
    [mutableParallelArray addObject:object1];
    [mutableParallelArray removeObject:object0];
    XCTAssertTrue([mutableParallelArray objectAtIndex:0] == object1,
                  "object0 at index 0 should have been replaced by object1");
}

- (void)testAsArray
{
    MKMutableParallelArray *mutableParallelArray = [[MKMutableParallelArray alloc] init];
    NSString               *object0              = @"Object1";
    NSString               *object1              = @"Object1";
    [mutableParallelArray addObject:object0];
    [mutableParallelArray addObject:object1];
    NSArray *array = mutableParallelArray.asArray;
    [mutableParallelArray removeObject:array[0]];
    XCTAssertTrue([mutableParallelArray objectAtIndex:0] == object1,
                  "object0 at index 0 should have been replaced by object1");
}

@end
