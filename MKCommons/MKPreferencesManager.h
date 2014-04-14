//
//  MKPreferencesManager.h
//  Ping Monitor
//
//  Created by Michael Kuck on 9/24/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const MKPreferencesManagerKeysDidChangeNotification;
extern NSString *const MKPreferencesManagerChangedKeys;

/**
 * Stores and reads values to and from both NSUserDefaults and iCloud. 
 *
 * As long as iCloud KVS is available (should be even the case when it's 
 * disabled or offline), iCloud always holds the truth. NSUserDefaults will 
 * only be used as a backup.
*/
@interface MKPreferencesManager : NSObject

@property (nonatomic, assign) BOOL shouldUseICloud;

+ (MKPreferencesManager *)defaultManager;

- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (void)setDouble:(double)value forKey:(NSString *)key;
- (void)setInteger:(NSInteger)value forKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;

- (BOOL)boolForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

- (void)resetPreferences;

- (void)synchronize;

@end
