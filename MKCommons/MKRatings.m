//
//  MKRatings.m
//  Ping Monitor
//
//  Created by Michael Kuck on 11/10/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKRatings.h"

#import "MKPreferencesManager.h"
#import "MKLog.h"

static NSString *const MKRatingsAppOpenedCounterKey = @"app-opened-counter";
static NSString *const MKRatingslastPopupDateKey = @"last-popup-date";

@interface MKRatings ()

@property (nonatomic, assign) NSUInteger appOpenedCounter;
@property (nonatomic, assign) NSDate *lastPopDate;
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
    if (self.appOpenedCounter > 10) {
        [self showRatingsPopup];
    }
}

#pragma mark - Private Implementation

- (void)showRatingsPopup {
    // TODO: implement
}

@end
