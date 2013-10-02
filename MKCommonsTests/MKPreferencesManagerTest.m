//
//  MKPreferencesManagerTest.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/24/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>
extern void __gcov_flush();

#import "MKPreferencesManager.h"

static NSString *const TEST_KEY1 = @"MKPreferencesManagerTestKey1";
static NSString *const TEST_KEY2 = @"MKPreferencesManagerTestKey2";

@interface MKPreferencesManagerTest : XCTestCase

@property (nonatomic, assign) BOOL iCloudNotificationReceived;

- (void)cleanup;
- (void)receiveICloudNotification:(NSNotification *)notification;


@end

@implementation MKPreferencesManagerTest

- (void)setUp
{
    [super setUp];
    [self cleanup];
}

- (void)tearDown
{
    [self cleanup];
#ifdef COVERAGE
    __gcov_flush();
#endif
    [super tearDown];
}

- (void)cleanup {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[MKPreferencesManager defaultManager] removeObjectForKey:TEST_KEY1];
    [[MKPreferencesManager defaultManager] removeObjectForKey:TEST_KEY2];
}

- (void)testSetAndGetBool
{
    BOOL testValue1 = YES;
    XCTAssertEqualObjects(nil, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should not exist yet.");
    
    [[MKPreferencesManager defaultManager] setBool:testValue1 forKey:TEST_KEY1];
    
    XCTAssertNotEqualObjects(nil, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should exist now.");
    XCTAssertEqual(testValue1, [[MKPreferencesManager defaultManager] boolForKey:TEST_KEY1], @"Key should exist now.");
    
    [[MKPreferencesManager defaultManager] synchronize];
    [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:TEST_KEY1];
    XCTAssertEqual(testValue1, [[MKPreferencesManager defaultManager] boolForKey:TEST_KEY1], @"Key should still exist locally.");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TEST_KEY1];
    XCTAssertNotEqual(testValue1, [[MKPreferencesManager defaultManager] boolForKey:TEST_KEY1], @"Key should still not exist anymore");
    
}

- (void)testSetAndGetDouble
{
    double testValue = 1.5f;
    XCTAssertEqualObjects(nil, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should not exist yet.");
    
    [[MKPreferencesManager defaultManager] setDouble:testValue forKey:TEST_KEY1];
    
    XCTAssertNotEqualObjects(nil, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should exist now.");
    XCTAssertEqual(testValue, [[MKPreferencesManager defaultManager] doubleForKey:TEST_KEY1], @"Key should exist now.");
    
    [[MKPreferencesManager defaultManager] synchronize];
    [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:TEST_KEY1];
    XCTAssertEqual(testValue, [[MKPreferencesManager defaultManager] doubleForKey:TEST_KEY1], @"Key should still exist locally.");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TEST_KEY1];
    XCTAssertNotEqual(testValue, [[MKPreferencesManager defaultManager] doubleForKey:TEST_KEY1], @"Key should still not exist anymore");
}

- (void)testSetAndGetInteger
{
    NSInteger testValue = 11;
    XCTAssertEqualObjects(nil, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should not exist yet.");
    
    [[MKPreferencesManager defaultManager] setInteger:testValue forKey:TEST_KEY1];
    
    XCTAssertNotEqualObjects(nil, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should exist now.");
    XCTAssertEqual(testValue, [[MKPreferencesManager defaultManager] integerForKey:TEST_KEY1], @"Key should exist now.");
    
    [[MKPreferencesManager defaultManager] synchronize];
    [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:TEST_KEY1];
    XCTAssertEqual(testValue, [[MKPreferencesManager defaultManager] integerForKey:TEST_KEY1], @"Key should still exist locally.");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TEST_KEY1];
    XCTAssertNotEqual(testValue, [[MKPreferencesManager defaultManager] integerForKey:TEST_KEY1], @"Key should still not exist anymore");
}

- (void)testSetAndGetObject
{
    NSString *testValue = @"Test";
    XCTAssertEqualObjects(nil, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should not exist yet.");
    
    [[MKPreferencesManager defaultManager] setObject:testValue forKey:TEST_KEY1];
    
    XCTAssertEqualObjects(testValue, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should exist now.");
    
    [[MKPreferencesManager defaultManager] synchronize];
    [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:TEST_KEY1];
    XCTAssertEqual(testValue, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should still exist locally.");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TEST_KEY1];
    XCTAssertNotEqual(testValue, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should still not exist anymore");
}

- (void)testMissingKey
{
    NSString *testValue = @"Test";
    [[MKPreferencesManager defaultManager] setObject:testValue forKey:TEST_KEY1];
    XCTAssertEqualObjects(testValue, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should exist.");
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TEST_KEY1];
    XCTAssertEqualObjects(testValue, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should still exist as it is still stored in iCloud.");
    [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:TEST_KEY1];
    XCTAssertEqualObjects(testValue, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should still exist as it is still stored locally.");
}

- (void)testDifferentKeys
{
    NSString *testValue = @"Test";
    [[MKPreferencesManager defaultManager] setObject:testValue forKey:TEST_KEY1];
    XCTAssertEqualObjects(testValue, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should exist.");
    
    [[NSUserDefaults standardUserDefaults] setObject:@"ShouldntBeUsed" forKey:TEST_KEY1];
    XCTAssertEqualObjects(testValue, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"iCloud value should still be used.");
}

- (void)receiveICloudNotification:(NSNotification *)notification {
    self.iCloudNotificationReceived = YES;
}

- (void)testUpdateNotification
{
    self.iCloudNotificationReceived = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveICloudNotification:)
                                                 name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object:nil];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    NSArray *changedKeys = [NSArray arrayWithObject:TEST_KEY1];
    [userInfo setObject:changedKeys forKey:NSUbiquitousKeyValueStoreChangedKeysKey];
    [userInfo setObject:[NSNumber numberWithInteger:NSUbiquitousKeyValueStoreInitialSyncChange]
                 forKey:NSUbiquitousKeyValueStoreChangeReasonKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                        object:[NSUbiquitousKeyValueStore defaultStore]
                                                      userInfo:userInfo];
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // Begin a run loop terminated when the downloadComplete it set to true
    NSDate *testExpireDate = [[NSDate date] dateByAddingTimeInterval:10];
    while (!self.iCloudNotificationReceived && [runLoop runMode:NSDefaultRunLoopMode beforeDate:testExpireDate]);
    XCTAssertEqual(self.iCloudNotificationReceived, YES, @"iCloud notification should have been received.");
}

- (void)testRemoveObject
{
    NSString *testValue = @"Test";
    [[MKPreferencesManager defaultManager] setObject:testValue forKey:TEST_KEY1];
    XCTAssertEqualObjects(testValue, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should exist.");
    
    [[MKPreferencesManager defaultManager] removeObjectForKey:TEST_KEY1];
    
    XCTAssertEqualObjects(nil, [[MKPreferencesManager defaultManager] objectForKey:TEST_KEY1], @"Key should not exist anymore.");
}

@end
