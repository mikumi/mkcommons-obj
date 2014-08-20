//
// Created by Michael Kuck on 8/20/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "NSError+MKCommons.h"

//============================================================
//== Implementation
//============================================================
@implementation NSError (MKCommons)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code message:(NSString *)message;
{
    NSDictionary *const userInfo = @{NSLocalizedDescriptionKey : message};
    NSError      *const error    = [NSError errorWithDomain:domain code:code userInfo:userInfo];
    return error;
}

@end