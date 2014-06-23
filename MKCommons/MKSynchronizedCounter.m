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

@synthesize counter = _counter;

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
    @synchronized(self) {
        self.counter += 1;
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)decrement
{
    @synchronized(self) {
        self.counter -= 1;
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSInteger)count
{
    @synchronized(self) {
        return _counter;
    }
}

@end
