//
//  MKRatings.h
//  MKCommons
//
//  Created by Michael Kuck on 12/22/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@interface MKRatings : NSObject

@property (nonatomic, strong) UIViewController *parentViewController;

+ (MKRatings *)defaultManager;
- (void)recordEventAppOpened;
- (void)showPopupIfRequirementsMatch;

@end
