//
//  MKPreferencesManagerTest.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/24/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "MKPreferencesManager.h"

static NSString *const UserDefaultsTestSuite = @"testSuite";

@interface MKPreferencesManagerTest : XCTestCase

@property (nonatomic, strong) NSUserDefaults *mockUserDefaults;
@property (nonatomic, strong) NSUserDefaults *realUserDefaults;
@property (nonatomic, strong) NSUbiquitousKeyValueStore *mockUbiquitousKeyValueStore;
@property (nonatomic, strong) NSUbiquitousKeyValueStore *realUbiquitousKeyValueStore;

@end

@implementation MKPreferencesManagerTest

- (void)setUp
{
    [super setUp];
    [[NSUserDefaults standardUserDefaults] removeSuiteNamed:UserDefaultsTestSuite];
    self.mockUserDefaults = OCMClassMock([NSUserDefaults class]);
    self.realUserDefaults = OCMPartialMock([[NSUserDefaults alloc] initWithSuiteName:UserDefaultsTestSuite]);
    self.mockUbiquitousKeyValueStore = OCMClassMock([NSUbiquitousKeyValueStore class]);
    self.realUbiquitousKeyValueStore = OCMPartialMock([[NSUbiquitousKeyValueStore alloc] init]);
    [[[self.realUserDefaults dictionaryRepresentation] allKeys]
            enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self.realUserDefaults removeObjectForKey:obj];
            }];
}

- (void)tearDown
{
    [[NSUserDefaults standardUserDefaults] removeSuiteNamed:UserDefaultsTestSuite];
    [[[self.realUserDefaults dictionaryRepresentation] allKeys]
            enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self.realUserDefaults removeObjectForKey:obj];
            }];
    [super tearDown];
}

- (void)testReset
{
    MKPreferencesManager *const preferencesManager = [[MKPreferencesManager alloc]
            initWithUserDefaults:self.realUserDefaults
            ubiquitousKeyValueStore:self.mockUbiquitousKeyValueStore];

    NSString *const testKey1 = @"foo-key";
    NSString *const testKey2 = @"bar-key";
    [self.realUserDefaults setObject:@"foo-value" forKey:testKey1];
    [self.realUserDefaults setObject:@"bar-value" forKey:testKey2];

    NSDictionary *const testICloudDictionary = @{testKey1 : @"foo", testKey2 : @"bar"};
    OCMStub([self.mockUbiquitousKeyValueStore dictionaryRepresentation]).andReturn(testICloudDictionary);

    [preferencesManager resetPreferences];
    XCTAssertTrue([self.realUserDefaults objectForKey:testKey1] == nil);
    XCTAssertTrue([self.realUserDefaults objectForKey:testKey2] == nil);
    OCMVerify([self.realUserDefaults synchronize]);

    OCMVerify([self.mockUbiquitousKeyValueStore removeObjectForKey:testKey1]);
    OCMVerify([self.mockUbiquitousKeyValueStore removeObjectForKey:testKey2]);
    OCMVerify([self.mockUbiquitousKeyValueStore synchronize]);
}

@end
