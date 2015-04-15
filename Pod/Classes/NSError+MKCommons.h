//
// Created by Michael Kuck on 8/20/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (MKCommons)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code message:(NSString *)message;

@end