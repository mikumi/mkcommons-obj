//
//  MKPreferencesManager.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/24/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKPreferencesManager.h"

#import "MKLog.h"

typedef void (^MKReadValueFromICloudBlock)(BOOL needsSync);
typedef void (^MKReadValueFromUserDefaultsBlock)(BOOL needsSync);

NSString *const MKPreferencesManagerKeysDidChangeNotification = @"MKPreferencesManagerKeysDidChangeNotification";
NSString *const MKPreferencesManagerChangedKeys = @"MKPreferencesManagerChangedKeys";

@interface MKPreferencesManager ()

- (NSUbiquitousKeyValueStore *)iCloudStore;
- (NSUserDefaults *)localStore;

- (void)iCloudUpdate:(NSNotification *)notification;

@end

@implementation MKPreferencesManager

#pragma mark - Public methods

/*
 * (Inherited method comment)
 */
- (void)dealloc {
   [[NSNotificationCenter defaultCenter] removeObserver:self]; 
}

/*
 * (Inherited method comment)
 */
- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(iCloudUpdate:)
                                                     name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                   object:[NSUbiquitousKeyValueStore defaultStore]];
        [[NSUbiquitousKeyValueStore defaultStore] synchronize];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return self;
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (MKPreferencesManager *)defaultManager {
    static dispatch_once_t onceToken;
    static MKPreferencesManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MKPreferencesManager alloc] init];
    });
    return sharedInstance;
}

/**
 * Synchronizes iCloud and local storage
 */
- (void)synchronize {
    [self.localStore synchronize];
    [self.iCloudStore synchronize];
    // TODO: synchronize all keys
}

- (void)setBool:(BOOL)value forKey:(NSString *)key {
    [self.localStore setBool:value forKey:key];
    [self.iCloudStore setBool:value forKey:key];
}

- (void)setDouble:(double)value forKey:(NSString *)key {
    [self.localStore setDouble:value forKey:key];
    [self.iCloudStore setDouble:value forKey:key];
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)key {
    [self.localStore setInteger:value forKey:key];
    [self.iCloudStore setLongLong:value forKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key {
    [self.localStore setObject:object forKey:key];
    [self.iCloudStore setObject:object forKey:key];
}

- (BOOL)boolForKey:(NSString *)key {
    BOOL value = NO;
    if ([self.iCloudStore objectForKey:key] != nil) {
        value = [self.iCloudStore boolForKey:key];
        [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    } else {
        value = [self.localStore boolForKey:key];
    }
    return value;
}

- (double)doubleForKey:(NSString *)key {
    double value = 0.0f;
    if ([self.iCloudStore objectForKey:key] != nil) {
        value = [self.iCloudStore doubleForKey:key];
        [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
    } else {
        value = [self.localStore doubleForKey:key];
    }
    return value;
}

- (NSInteger)integerForKey:(NSString *)key {
    NSInteger value = 0;
    if ([self.iCloudStore objectForKey:key] != nil) {
        value = (NSInteger)[self.iCloudStore longLongForKey:key];
        [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    } else {
        value = [self.localStore integerForKey:key];
    }
    return value;
}

- (id)objectForKey:(NSString *)key {
    id value = nil;
    if ([self.iCloudStore objectForKey:key] != nil) {
        value = [self.iCloudStore objectForKey:key];
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    } else {
        value = [self.localStore objectForKey:key];
    }
    return value;
}

- (void)removeObjectForKey:(NSString *)key {
    [self.localStore removeObjectForKey:key];
    [self.iCloudStore removeObjectForKey:key];
}

#pragma mark - Private methods

/**
 * // TODO: this method comment needs be updated.
 */
- (NSUbiquitousKeyValueStore *)iCloudStore {
    return [NSUbiquitousKeyValueStore defaultStore];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (NSUserDefaults *)localStore {
    return [NSUserDefaults standardUserDefaults];
}

- (void)iCloudUpdate:(NSNotification *)notification {
    NSNumber *reason = [[notification userInfo] objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey];
    if (reason) {
        NSInteger reasonValue = [reason integerValue];
        if ((reasonValue == NSUbiquitousKeyValueStoreServerChange) ||
            (reasonValue == NSUbiquitousKeyValueStoreInitialSyncChange)) {
            NSArray *keys = [[notification userInfo] objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];
            MKLogInfo(@"iCloud update received with %u changed keys.", [keys count]);
            
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            [userInfo setObject:keys forKey:MKPreferencesManagerChangedKeys];
            [[NSNotificationCenter defaultCenter] postNotificationName:MKPreferencesManagerKeysDidChangeNotification
                                                                object:self
                                                              userInfo:userInfo];
        }
    }
}

@end
