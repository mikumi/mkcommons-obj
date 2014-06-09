//
//  MKFallbackQueue.h
//  Ping Monitor
//
//  Created by Michael Kuck on 9/25/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * // DOCU: this method comment needs be updated.
 */
@interface MKFallbackQueue : NSObject

- (instancetype)initWithObjects:(NSArray *)objects;

- (id)topObject;
- (id)moveTopObjectToBottomAndGetNextOne;

@end
