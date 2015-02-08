//
// Created by Michael Kuck on 1/29/15.
// Copyright (c) 2015 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MKPermissionType)
{
    MKPermissionTypePushNotifications
};

typedef void (^MKPermissionUtilAskCompletion)(BOOL didAccept);

//============================================================
//== Public Interface
//============================================================
@interface MKPermissionUtil : NSObject

- (BOOL)hasAskedPermission:(MKPermissionType)permissionType;
- (void)askForPermission:(MKPermissionType)permissionType title:(NSString *)title message:(NSString *)message
                yesTitle:(NSString *)yesTitle noTitle:(NSString *)noTitle
              completion:(MKPermissionUtilAskCompletion)completion;

@end