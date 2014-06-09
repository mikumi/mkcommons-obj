//
// Created by Michael Kuck on 5/27/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const MKMutableParallelArrayDidChangeNotification = @"MKMutableParallelArrayDidChangeNotification";

//============================================================
//== Public Interface
//============================================================
@interface MKMutableParallelArray : NSObject <NSCoding>

- (void)addObject:(id)object;
- (id)objectAtIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)removeObject:(id)object;
- (NSUInteger)indexOfObject:(id)object;
- (BOOL)contains:(id)object;
- (NSArray *)asArray;
- (NSUInteger)count;

@end
