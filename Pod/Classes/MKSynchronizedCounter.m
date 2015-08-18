//
// Created by Michael Kuck on 6/23/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKSynchronizedCounter.h"

//============================================================
//== Private Interface
//============================================================
@interface MKSynchronizedCounter ()

@property (assign, atomic) NSInteger counter;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKSynchronizedCounter

/*
 * (Inherited Comment)
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _counter = 0;
    }
    return self;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)increment
{
    [self incrementAndDo:nil];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)incrementAndDo:(void (^)(NSInteger newValue))completionBlock
{
    @synchronized(self) {
        self.counter += 1;
        if (completionBlock) {
            completionBlock(self.counter);
        }
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)decrement
{
    [self decrementAndDo:nil];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)decrementAndDo:(void (^)(NSInteger newValue))completionBlock
{
    @synchronized(self) {
        self.counter -= 1;
        if (completionBlock) {
            completionBlock(self.counter);
        }
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)set:(NSInteger)value
{
    [self set:value andDo:nil];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)set:(NSInteger)value andDo:(void (^)(NSInteger newValue))completionBlock
{
    @synchronized(self) {
        self.counter = value;
        if (completionBlock) {
            completionBlock(self.counter);
        }
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSInteger)get
{
    return [self getAndDo:nil];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSInteger)getAndDo:(void (^)(NSInteger currentValue))completionBlock
{
    @synchronized(self) {
        if (completionBlock) {
            completionBlock(self.counter);
        }
        return self.counter;
    }
}

@end
