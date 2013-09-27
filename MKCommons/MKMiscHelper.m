//
//  MKMiscHelper.m
//  Ping Monitor
//
//  Created by Michael Kuck on 6/27/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKMiscHelper.h"

@implementation MKMiscHelper

+ (NSInteger)positionOfString:(NSString *)string inArray:(NSArray *)array {
    __block NSInteger position = -1;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:string]) {
            position = (NSInteger)idx;
            *stop = YES;
        }
    }];
    return position;
}

+ (BOOL)isLegacyPlatform {
    BOOL iOS6OrLess = kCFCoreFoundationVersionNumber <= kCFCoreFoundationVersionNumber_iOS_6_1;
    if (iOS6OrLess) {
        return YES;
    } else {
        return NO;
    }
}


@end
