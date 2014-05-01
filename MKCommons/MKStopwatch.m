//
//  MKStopwatch.m
//  Server Monitor
//
//  Created by Michael Kuck on 6/19/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKStopwatch.h"

@interface MKStopwatch ()

@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval stopTime;


@end

@implementation MKStopwatch

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reset];
    }
    return self;
}

- (void)start
{
    [self reset];
}

- (void)stop
{
    self.stopTime = [NSDate timeIntervalSinceReferenceDate];
}

- (void)reset
{
    self.startTime = [NSDate timeIntervalSinceReferenceDate];
    self.stopTime = self.startTime;
}

- (NSTimeInterval)timeDifference
{
    return self.stopTime - self.startTime;
}


@end
