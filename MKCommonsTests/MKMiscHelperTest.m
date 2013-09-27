//
//  MKMiscHelperTest.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/22/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MKMiscHelper.h"

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
//    void (^blockWithNoArgs)() = ^(){
//        NSLog(@"This is a block with no args");
//    };
    
    void (^blockWith1Arg)(NSNumber *) = ^(NSNumber *number1){
        NSLog(@"This is a block with a number %d", [number1 integerValue]);
    };
    
    void (^blockWith2Args)(NSNumber *, NSNumber *) = ^(NSNumber *number1, NSNumber *number2){
        NSLog(@"This is a block with numbers %d and %d", [number1 integerValue], [number2 integerValue]);
    };
    
    void (^blockWith3Args)(NSNumber *, NSNumber *, NSNumber *) = ^(NSNumber *number1, NSNumber *number2, NSNumber *number3){
        NSLog(@"This is a block with numbers %d, %d and %d", [number1 integerValue], [number2 integerValue], [number3 integerValue]);
    };
    
//    BLOCK_SAFE_RUN(blockWithNoArgs);
    executeBlock(blockWith1Arg, [NSNumber numberWithInt:1]);
    executeBlock(blockWith2Args, [NSNumber numberWithInt:1], [NSNumber numberWithInt:2]);
    executeBlock(blockWith3Args, [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3]);
    
}

@end
