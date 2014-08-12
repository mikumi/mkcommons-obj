//
// Created by Michael Kuck on 8/12/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "NSString+MKCommons.h"

//============================================================
//== Implementation
//============================================================
@implementation NSString (MKCommons)

- (BOOL)containsString:(NSString *)substring
{
    if ([self rangeOfString:substring].location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

@end
