//
// Created by Michael Kuck on 8/20/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

//============================================================
//== MKUITheme protocol
//============================================================
@protocol MKUIThemeProtocol<NSObject>

+ (UIColor *)lightThemeColor;
+ (UIColor *)normalThemeColor;
+ (UIColor *)darkThemeColor;

+ (UIStatusBarStyle)statusBarStyle;

+ (UIColor *)navigationBarContentColor;

+ (CGFloat)bigViewPadding;
+ (CGFloat)defaultViewPadding;

+ (void)configureApplication;

@end
