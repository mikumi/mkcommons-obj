//
//  MKRatings.m
//  MKCommons
//
//  Created by Michael Kuck on 12/22/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKRatings.h"

// External Frameworks
#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

// Project Headers
#import "MKPreferencesManager.h"
#import "MKLog.h"

static NSString *const MKRatingsAppOpenedCounterKey = @"app-opened-counter";
static NSString *const MKRatingslastPopupDateKey = @"last-popup-date";

@interface MKRatings () <SKStoreProductViewControllerDelegate>

@property (nonatomic, assign) NSUInteger appOpenedCounter;
@property (nonatomic, assign) NSDate *lastPopDate;
@property (nonatomic, assign) NSDate *appInstalledDate;
@property (nonatomic, assign) BOOL isFullyInitialized;

- (void)showRatingsPopup;

@end

@implementation MKRatings

#pragma mark - Public Implementation

/*
 * (Inherited Comment)
 */
- (id)init
{
    self = [super init];
    if (self) {
        _appOpenedCounter = 0;
        _lastPopDate = nil;
        _isFullyInitialized = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _appOpenedCounter = _appOpenedCounter + [[MKPreferencesManager defaultManager] integerForKey:MKRatingsAppOpenedCounterKey];
            _lastPopDate = [[MKPreferencesManager defaultManager] objectForKey:MKRatingslastPopupDateKey];
            if (_lastPopDate == nil) {
                _lastPopDate = [NSDate date];
                [[MKPreferencesManager defaultManager] setObject:_lastPopDate forKey:MKRatingslastPopupDateKey];
            }
        });
        _isFullyInitialized = YES;
    }
    return self;
}

/**
 * Get the singleton instance
 *
 * @return Singleton instance of MKRatings
 */
+ (MKRatings *)defaultManager {
    static dispatch_once_t onceToken;
    static MKRatings *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MKRatings alloc] init];
    });
    return sharedInstance;
}

- (void)recordEventAppOpened {
    if (!self.isFullyInitialized) {
        MKLogWarning(@"MKRatings has not finished initializing itself yet");
        return;
    }
    self.appOpenedCounter = self.appOpenedCounter + 1;
    [[MKPreferencesManager defaultManager] setInteger:self.appOpenedCounter forKey:MKRatingsAppOpenedCounterKey];
}

- (void)showPopupIfRequirementsMatch {
    if (self.appOpenedCounter > 0) {
        [self showRatingsPopup];
    }
}

#pragma mark - Private Implementation

- (void)showRatingsPopup {
    if (self.parentViewController == nil) {
        MKLogError(@"Parent view controller not set.");
        return;
    } else {
        MKLogInfo(@"Showing ratings popup...");
    }
    
    CGFloat const ratingsPopupHeight = 200;
    
    CGRect ratingsBounds = self.parentViewController.view.bounds;
    ratingsBounds.size.height = ratingsBounds.size.height = ratingsPopupHeight;
    ratingsBounds.origin.y = (self.parentViewController.view.bounds.size.height / 2) - (ratingsBounds.size.height / 2);
    
    UIView *ratingsView = [[UIView alloc] initWithFrame:ratingsBounds];
    ratingsView.backgroundColor = [UIColor whiteColor];
    ratingsView.alpha = 0.5f;
    
    [self.parentViewController.view addSubview:ratingsView];
    
//    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
//    [storeProductViewController setDelegate:self];
//    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"664943649"} completionBlock:^(BOOL result, NSError *error) {
//        if (error) {
//            MKLogError(@"%@", [error localizedDescription]);
//        } else {
//            [self.parentViewController presentViewController:storeProductViewController animated:YES completion:nil];
//        }
//    }];
}

@end
