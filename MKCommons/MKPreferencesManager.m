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
NSString *const MKPreferencesManagerChangedKeys               = @"MKPreferencesManagerChangedKeys";

@interface MKPreferencesManager ()

@property (strong, atomic, readonly) NSMutableArray *ignoreListForSyncing;

- (NSUbiquitousKeyValueStore *)iCloudStore;
- (NSUserDefaults *)localStore;

- (void)iCloudUpdate:(NSNotification *)notification;

@end

@implementation MKPreferencesManager

#pragma mark - Public methods

/*
 * (Inherited method comment)
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 * (Inherited method comment)
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldUseICloud = YES;
        _ignoreListForSyncing = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iCloudUpdate:)
                                                     name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                   object:[NSUbiquitousKeyValueStore defaultStore]];
        [[NSUbiquitousKeyValueStore defaultStore] synchronize];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return self;
}

/**
 * // DOCU: this method comment needs be updated.
 */
+ (MKPreferencesManager *)defaultManager
{
    static dispatch_once_t      onceToken;
    static MKPreferencesManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MKPreferencesManager alloc] init];
    });
    return sharedInstance;
}

/**
 * Synchronizes iCloud and local storage
 */
- (void)synchronize
{
    [self.localStore synchronize];
    [self.iCloudStore synchronize];
    // TODO: synchronize all keys
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)setBool:(BOOL)value forKey:(NSString *)key
{
    [self.localStore setBool:value forKey:key];
    if (![self.ignoreListForSyncing containsObject:key]) {
        [self.iCloudStore setBool:value forKey:key];
    }
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)setDouble:(double)value forKey:(NSString *)key
{
    [self.localStore setDouble:value forKey:key];
    if (![self.ignoreListForSyncing containsObject:key]) {
        [self.iCloudStore setDouble:value forKey:key];
    }
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)setInteger:(NSInteger)value forKey:(NSString *)key
{
    [self.localStore setInteger:value forKey:key];
    if (![self.ignoreListForSyncing containsObject:key]) {
        [self.iCloudStore setLongLong:value forKey:key];
    }
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)setObject:(id)object forKey:(NSString *)key
{
    [self.localStore setObject:object forKey:key];
    if (![self.ignoreListForSyncing containsObject:key]) {
        [self.iCloudStore setObject:object forKey:key];
    }
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (BOOL)boolForKey:(NSString *)key
{
    BOOL value = NO;
    if ((![self.ignoreListForSyncing containsObject:key]) && ([self.iCloudStore objectForKey:key] != nil)) {
        value = [self.iCloudStore boolForKey:key];
        [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    } else {
        value = [self.localStore boolForKey:key];
    }
    return value;
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (double)doubleForKey:(NSString *)key
{
    double value = 0.0f;
    if ((![self.ignoreListForSyncing containsObject:key]) && ([self.iCloudStore objectForKey:key] != nil)) {
        value = [self.iCloudStore doubleForKey:key];
        [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
    } else {
        value = [self.localStore doubleForKey:key];
    }
    return value;
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (NSInteger)integerForKey:(NSString *)key
{
    NSInteger value = 0;
    if ((![self.ignoreListForSyncing containsObject:key]) && ([self.iCloudStore objectForKey:key] != nil)) {
        value = (NSInteger)[self.iCloudStore longLongForKey:key];
        [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    } else {
        value = [self.localStore integerForKey:key];
    }
    return value;
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (id)objectForKey:(NSString *)key
{
    id value = nil;
    if ((![self.ignoreListForSyncing containsObject:key]) && ([self.iCloudStore objectForKey:key] != nil)) {
        value = [self.iCloudStore objectForKey:key];
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    } else {
        value = [self.localStore objectForKey:key];
    }
    return value;
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)removeObjectForKey:(NSString *)key
{
    [self.localStore removeObjectForKey:key];
    [self.iCloudStore removeObjectForKey:key];
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)resetPreferences
{
    [[[NSUbiquitousKeyValueStore defaultStore] dictionaryRepresentation]
            enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:key];
            }];
    [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]
            enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
            }];
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)addSyncIgnoreKey:(NSString *)key
{
    @synchronized(self.ignoreListForSyncing) {
        if (![self.ignoreListForSyncing containsObject:key]) {
            [self.ignoreListForSyncing addObject:key];
        }
        assert([self.ignoreListForSyncing containsObject:key]);
    }
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)removeSyncIgnoreKey:(NSString *)key
{
    @synchronized(self.ignoreListForSyncing) {
        if ([self.ignoreListForSyncing containsObject:key]) {
            [self.ignoreListForSyncing removeObject:key];
        }
        assert(![self.ignoreListForSyncing containsObject:key]);
    }
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (NSArray *)syncIgnoreKeys
{
    @synchronized(self.ignoreListForSyncing) {
        return [NSArray arrayWithArray:self.ignoreListForSyncing];
    }
}

#pragma mark - Private methods

/**
 * // DOCU: this method comment needs be updated.
 */
- (NSUbiquitousKeyValueStore *)iCloudStore
{
    if (self.shouldUseICloud) {
        return [NSUbiquitousKeyValueStore defaultStore];
    } else {
        return nil;
    }
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (NSUserDefaults *)localStore
{
    return [NSUserDefaults standardUserDefaults];
}

- (void)iCloudUpdate:(NSNotification *)notification
{
    if (!self.shouldUseICloud) {
        return;
    }
    NSNumber *const reason = notification.userInfo[NSUbiquitousKeyValueStoreChangeReasonKey];
    if (reason) {
        NSInteger reasonValue = [reason integerValue];
        if ((reasonValue == NSUbiquitousKeyValueStoreServerChange) ||
            (reasonValue == NSUbiquitousKeyValueStoreInitialSyncChange)) {
            NSArray *const keys = notification.userInfo[NSUbiquitousKeyValueStoreChangedKeysKey];
            MKLogInfo(@"iCloud update received with %lu changed keys.", (unsigned long)[keys count]);

            NSMutableDictionary *const userInfo = [[NSMutableDictionary alloc] init];
            userInfo[MKPreferencesManagerChangedKeys] = keys;
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:MKPreferencesManagerKeysDidChangeNotification object:self userInfo:userInfo];
        }
    }
}

@end
