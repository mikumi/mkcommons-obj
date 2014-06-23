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
- (void)decrement;
- (NSInteger)count;

@end
