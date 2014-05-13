//
//  MKFallbackQueue.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/25/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKFallbackQueue.h"

@interface MKFallbackQueue ()

@property (nonatomic, strong, readonly) NSMutableArray *fallbackQueue;

@end

@implementation MKFallbackQueue

/*
 * (Inherited method comment)
 */
- (instancetype)init
{
    return [self initWithObjects:nil];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (instancetype)initWithObjects:(NSArray *)objects
{
    self = [super init];
    if (self) {
        if (objects != nil) {
            _fallbackQueue = [NSMutableArray arrayWithArray:objects];
        } else {
            _fallbackQueue = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

/**
 * // TODO: this method comment needs be updated.
 */
- (id)topObject
{
    id const firstObject = [self.fallbackQueue firstObject];
    return firstObject;
}

/**
 * // TODO: this method comment needs be updated.
 */
- (id)moveTopObjectToBottomAndGetNextOne
{
    if ([self.fallbackQueue count] <= 0) {
        return nil;
    }
    id const firstObject = [self.fallbackQueue firstObject];
    [self.fallbackQueue removeObjectAtIndex:0];
    [self.fallbackQueue addObject:firstObject];
    id const newFirstObject = [self.fallbackQueue firstObject];
    return newFirstObject;
}

@end
