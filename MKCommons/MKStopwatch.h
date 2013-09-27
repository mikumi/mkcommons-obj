//
//  MKStopwatch.h
//  Server Monitor
//
//  Created by Michael Kuck on 6/19/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKStopwatch : NSObject

- (id)init;

- (void)start;
- (void)stop;
- (void)reset;
- (NSTimeInterval)timeDifference;

@end
