//
//  MKBigLoadingIndicator.m
//  MKCommons
//
//  Created by Michael Kuck on 6/7/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

// TODO: don't just copy and paste MKLoadingIndicator. Do it properly

#import "MKBigLoadingIndicator.h"

#import "MKLog.h"

static NSString *const CounterLock = @"CounterLock";
static NSString *const ViewLock    = @"ViewLock";
static NSString *const TextLock    = @"TextLock";

static NSUInteger _counter           = 0;
static UIView     *_bigIndicatorView = nil;
static NSString   *_indicatorText    = @"Loading";

//============================================================
//== Private Interface
//============================================================
@interface MKBigLoadingIndicator ()

@property (strong, atomic) NSTimer *timeoutTimer;
@property (assign, atomic) BOOL    isLoading;

+ (void)increaseCounter;
+ (void)decreaseCounter;
+ (void)updateLoadingIndicator;
+ (void)bigNetworkActivityIndicatorVisible:(BOOL)isVisible;
+ (void)setIndicatorText:(NSString *)text;
+ (NSString *)indicatorText;

- (void)timeoutTimerEvent:(id)sender;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKBigLoadingIndicator

/*
 * (Inherited Comment)
 */
- (instancetype)init
{
    return [self initWithText:nil timeout:0];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (instancetype)initWithText:(NSString *)text
{
    return [self initWithText:text timeout:0];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (instancetype)initWithTimeout:(NSTimeInterval)timeout
{
    return [self initWithText:nil timeout:0];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (instancetype)initWithText:(NSString *)text timeout:(NSTimeInterval)timeout
{
    self = [super init];
    if (self) {
        _isLoading = YES;
        [MKBigLoadingIndicator setIndicatorText:text];
        [MKBigLoadingIndicator increaseCounter];
        if (timeout > 0) {
            _timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self
                                                           selector:@selector(timeoutTimerEvent:) userInfo:nil
                                                            repeats:NO];
        }
    }
    return self;
}

/*
 * (Inherited Comment)
 */
- (void)dealloc
{
    MKLogVerbose(@"dealloc");
    [self loadingDidFinish];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (void)loadingDidFinish
{
    @synchronized(self) {
        if (self.isLoading) {
            self.isLoading = NO;
            [MKBigLoadingIndicator decreaseCounter];
            [self.timeoutTimer invalidate];
            self.timeoutTimer = nil;
        }
    }
}

//=== Private Implementation ===//
#pragma mark - Private Implementation

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)increaseCounter
{
    @synchronized(CounterLock) {
        _counter++;
        MKLogVerbose(@"Counter was increased to %lu", (unsigned long)_counter);
        [MKBigLoadingIndicator updateLoadingIndicator];
    }
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)decreaseCounter
{
    @synchronized(CounterLock) {
        if (_counter > 0) {
            _counter--;
            MKLogVerbose(@"Counter was decreased to %lu", (unsigned long)_counter);
            [MKBigLoadingIndicator updateLoadingIndicator];
        }
    }
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)updateLoadingIndicator
{
    if (_counter > 0) {
        [MKBigLoadingIndicator bigNetworkActivityIndicatorVisible:YES];
    } else {
        [MKBigLoadingIndicator bigNetworkActivityIndicatorVisible:NO];
    }
}

/**
* // TODO: this method comment needs be updated.
*/
+ (void)bigNetworkActivityIndicatorVisible:(BOOL)isVisible
{
    @synchronized(ViewLock) {
        if (isVisible && _bigIndicatorView != nil) {
            [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_bigIndicatorView];
        } else if (isVisible && _bigIndicatorView == nil) {
            MKLogDebug(@"Creating big indicator view...");
            // TODO: use constraints
            // Setup Frame
            UIWindow *const keyWindow = [UIApplication sharedApplication].keyWindow;
            CGFloat const viewWidth      = 100;
            CGFloat const viewHeight     = 100;
            CGRect        indicatorFrame = keyWindow.frame;
            indicatorFrame.origin.x    = indicatorFrame.size.width / 2 - viewWidth / 2;
            indicatorFrame.origin.y    = indicatorFrame.size.height / 2 - viewHeight / 2;
            indicatorFrame.size.width  = viewWidth;
            indicatorFrame.size.height = viewHeight;

            // Indicator view container
            _bigIndicatorView = [[UIView alloc] initWithFrame:indicatorFrame];
            _bigIndicatorView.layer.cornerRadius  = 10.0f;
            _bigIndicatorView.layer.masksToBounds = YES;
            _bigIndicatorView.backgroundColor     = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];

            // Indicator view
            UIActivityIndicatorView *const indicatorView = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            indicatorView.frame = CGRectMake(35.0, 25.0, 30.0, 30.0);

            // Loading label
            UILabel *const label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 75.0, 80.0, 15.0)];
            label.backgroundColor = [UIColor clearColor];
            label.font            = [UIFont boldSystemFontOfSize:13.0];
            label.textColor       = [UIColor whiteColor];
            label.text            = [MKBigLoadingIndicator indicatorText];
            label.textAlignment   = NSTextAlignmentCenter;

            // Combine everything
            [_bigIndicatorView addSubview:indicatorView];
            [_bigIndicatorView addSubview:label];
            [indicatorView startAnimating];
            [keyWindow addSubview:_bigIndicatorView];
            [keyWindow bringSubviewToFront:_bigIndicatorView];
        } else if (_bigIndicatorView != nil) {
            [_bigIndicatorView removeFromSuperview];
            _bigIndicatorView = nil;
        }
    }
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)setIndicatorText:(NSString *)text
{
    @synchronized(TextLock) {
        if (text != nil) {
            _indicatorText = text;
        }
    }
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (NSString *)indicatorText
{
    @synchronized(TextLock) {
        return _indicatorText;
    }
}

/**
 * // TODO: this method comment needs be updated.
 */
- (void)timeoutTimerEvent:(id)sender
{
    MKLogDebug(@"Timeout has been reached.");
    [self loadingDidFinish];
}

@end
