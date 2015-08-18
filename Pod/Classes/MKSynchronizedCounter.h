//
// Created by Michael Kuck on 6/23/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

//============================================================
//== Public Interface
//============================================================
@interface MKSynchronizedCounter : NSObject

- (void)increment;
- (void)incrementAndDo:(void (^)(NSInteger newValue))completionBlock;
- (void)decrement;
- (void)decrementAndDo:(void (^)(NSInteger newValue))completionBlock;
- (void)set:(NSInteger)value;
- (void)set:(NSInteger)value andDo:(void (^)(NSInteger newValue))completionBlock;
- (NSInteger)get;
- (NSInteger)getAndDo:(void (^)(NSInteger currentValue))completionBlock;

@end
