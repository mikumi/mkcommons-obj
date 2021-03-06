//
// Created by Michael Kuck on 1/29/15.
// Copyright (c) 2015 Michael Kuck. All rights reserved.
//

#import "MKPermissionUtil.h"
#import "MKPreferencesManager.h"
#import "UIAlertView+MKCommons.h"

static NSString *const DidAskPermissionKeyPrefix = @"MKPermissionUtilDidAskPermission";

//============================================================
//== Private Interface
//============================================================
@interface MKPermissionUtil ()

@property (nonatomic, strong, readonly) MKPreferencesManager *preferencesManager;

@property (nonatomic, strong) UIAlertView *alert;

- (NSString *)permissionKeyForType:(MKPermissionType)permissionType;
- (void)storePermission:(BOOL)isPermitted forPermissionType:(MKPermissionType)permissionType;
- (void)requestNativePermission:(MKPermissionType)permissionType;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKPermissionUtil

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *const iCloudIgnoreKeys = @[[self permissionKeyForType:MKPermissionTypePushNotifications]];
        _preferencesManager             = [[MKPreferencesManager alloc]
                initWithUserDefaults:[NSUserDefaults standardUserDefaults]
                ubiquitousKeyValueStore:[NSUbiquitousKeyValueStore defaultStore]
                ignoredKeysForICloud:iCloudIgnoreKeys];
    }
    return self;
}

#pragma clang diagnostic push
#pragma ide diagnostic ignored "UnavailableInDeploymentTarget"
- (BOOL)hasAskedPermission:(MKPermissionType)permissionType
{
#ifndef MKCOMMONS_APP_EXTENSIONS
    if (permissionType == MKPermissionTypePushNotifications &&
            ![[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        return YES;
    }
    NSString *const preferencesKey = [self permissionKeyForType:permissionType];
    BOOL const hasAsked = [self.preferencesManager boolForKey:preferencesKey];
    return hasAsked;
#else
    return NO;
#endif
}
#pragma clang diagnostic pop

- (void)askForPermission:(MKPermissionType)permissionType title:(NSString *)title message:(NSString *)message
                yesTitle:(NSString *)yesTitle noTitle:(NSString *)noTitle
              completion:(MKPermissionUtilAskCompletion)completion
{
    if ([self hasAskedPermission:permissionType]) {
        if (completion) {
            completion(YES);
        }
        return;
    }

#ifndef MKCOMMONS_APP_EXTENSIONS
    self.alert = [[UIAlertView alloc]
            initWithTitle:title message:message delegate:self cancelButtonTitle:noTitle
            otherButtonTitles:yesTitle, nil];
    [self.alert showWithCompletion:^(NSInteger buttonIndex) {
        self.alert           = nil;
        BOOL const didPermit = (buttonIndex == 1);
        [self storePermission:didPermit forPermissionType:permissionType];
        if (didPermit) {
            [self requestNativePermission:permissionType];
        }
    }];
#endif
}

#pragma mark - Private Implementation

- (NSString *)permissionKeyForType:(MKPermissionType)permissionType
{
    return [NSString stringWithFormat:@"%@-%zd", DidAskPermissionKeyPrefix, permissionType];
}

- (void)storePermission:(BOOL)isPermitted forPermissionType:(MKPermissionType)permissionType
{
    NSString             *const preferencesKey     = [self permissionKeyForType:permissionType];
    [self.preferencesManager setBool:isPermitted forKey:preferencesKey];
    [self.preferencesManager synchronize];
}

- (void)requestNativePermission:(MKPermissionType)permissionType
{
    switch (permissionType) {
        case MKPermissionTypePushNotifications:
#pragma clang diagnostic push
#pragma ide diagnostic ignored "UnavailableInDeploymentTarget"
#ifndef MKCOMMONS_APP_EXTENSIONS
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
                [[UIApplication sharedApplication]
                        registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:
                                        UIUserNotificationTypeAlert | UIUserNotificationTypeBadge |
                                        UIUserNotificationTypeSound
                                categories:nil]];
            }
#endif
#pragma clang diagnostic pop
            break;

        default:
            break;
    }
}

@end