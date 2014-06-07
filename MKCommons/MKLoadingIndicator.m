//
//  MKLoadingIndicator.m
//  MKCommons
//
//  Created by Michael Kuck on 6/7/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKLoadingIndicator.h"
#import "MKLog.h"

static NSString *const CounterLock = @"CounterLock";
static NSUInteger counter = 0;

//============================================================
//== Private Interface
//============================================================
@interface MKLoadingIndicator ()

@property (strong, atomic) NSTimer *timeoutTimer;
@property (assign, atomic) BOOL    isLoading;

+ (void)increaseCounter;
+ (void)decreaseCounter;
+ (void)updateLoadingIndicator;

- (void)timeoutTimerEvent:(id)sender;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKLoadingIndicator

/*
 * (Inherited Comment)
 */
- (instancetype)init
{
    return [self initWithTimeout:30];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (instancetype)initWithTimeout:(NSTimeInterval)timeout;
{
    self = [super init];
    if (self) {
        _isLoading = YES;
        [MKLoadingIndicator increaseCounter];
        _timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self
                                                       selector:@selector(timeoutTimerEvent:) userInfo:nil repeats:NO];
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
            [MKLoadingIndicator decreaseCounter];
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
        counter++;
        MKLogVerbose(@"Counter was increased to %lu", (unsigned long)counter);
        [MKLoadingIndicator updateLoadingIndicator];
    }
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)decreaseCounter
{
    @synchronized(CounterLock) {
        if (counter > 0) {
            counter--;
            MKLogVerbose(@"Counter was decreased to %lu", (unsigned long)counter);
            [MKLoadingIndicator updateLoadingIndicator];

        }
    }
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)updateLoadingIndicator
{
    if (counter > 0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    } else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
