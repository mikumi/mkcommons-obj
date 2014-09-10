//
//  MKPreferencesManager.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/24/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKPreferencesManager.h"

#import "MKLog.h"
#import "MKSystemHelper.h"

typedef void (^MKReadValueFromICloudBlock)(BOOL needsSync);
typedef void (^MKReadValueFromUserDefaultsBlock)(BOOL needsSync);

NSString *const MKPreferencesManagerKeysDidChangeNotification = @"MKPreferencesManagerKeysDidChangeNotification";
NSString *const MKPreferencesManagerChangedKeys               = @"MKPreferencesManagerChangedKeys";

@interface MKPreferencesManager ()

@property (strong, atomic, readonly) NSMutableArray *ignoreListForSyncing;

@property (strong, nonatomic) NSUserDefaults *localStore;

- (NSUbiquitousKeyValueStore *)iCloudStore;

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
        _localStore = [NSUserDefaults standardUserDefaults];
        _shouldUseICloud = YES;
        _ignoreListForSyncing = [[NSMutableArray alloc] init];
        [self synchronize];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iCloudUpdate:)
                                                     name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                   object:[NSUbiquitousKeyValueStore defaultStore]];
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
        [self.localStore setBool:value forKey:key];
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
        [self.localStore setDouble:value forKey:key];
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
        [self.localStore setInteger:value forKey:key];
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
        [self.localStore setObject:value forKey:key];
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
    [[self.localStore dictionaryRepresentation]
            enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [self.localStore removeObjectForKey:key];
            }];
}

#pragma clang diagnostic push
#pragma ide diagnostic ignored "UnavailableInDeploymentTarget"
- (void)setSuiteNameForLocalStore:(NSString *)localStoreId
{
    if ([MKSystemHelper isOS7OrLessPlatform]) {
        MKLogError(@"Setting suite name is only supported on iOS 8.0+");
    } else {
        MKLogDebug(@"Setting suit name for local store to: %@", localStoreId)
        self.localStore = [[NSUserDefaults alloc] initWithSuiteName:localStoreId];
        [self.localStore synchronize];
    }
}
#pragma clang diagnostic pop

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
