//
//  MKMiscHelperTest.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/22/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MKCommons.h"

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
    [super tearDown];
}

- (void)testEvaluateBlock
{
    void (^blockWith1Arg)(NSNumber *) = ^(NSNumber *number1){
        MKLogVerbose(@"This is a block with a number %ld", (long)[number1 integerValue]);
    };
    
    void (^blockWith2Args)(NSNumber *, NSNumber *) = ^(NSNumber *number1, NSNumber *number2){
        MKLogVerbose(@"This is a block with numbers %ld and %ld", (long)[number1 integerValue], (long)[number2 integerValue]);
    };
    
    void (^blockWith3Args)(NSNumber *, NSNumber *, NSNumber *) = ^(NSNumber *number1, NSNumber *number2, NSNumber *number3){
        MKLogVerbose(@"This is a block with numbers %ld, %ld and %ld", (long)[number1 integerValue], (long)[number2 integerValue], (long)[number3 integerValue]);
    };
    
//    BLOCK_SAFE_RUN(blockWithNoArgs);
    executeBlock(blockWith1Arg, [NSNumber numberWithInt:1]);
    executeBlock(blockWith2Args, [NSNumber numberWithInt:1], [NSNumber numberWithInt:2]);
    executeBlock(blockWith3Args, [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3]);
    
}

@end
