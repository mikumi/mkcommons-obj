//
// Created by Michael Kuck on 8/12/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "NSString+MKCommons.h"

//============================================================
//== Implementation
//============================================================
@implementation NSString (MKCommons)

- (BOOL)containsSubstring:(NSString *)substring
{
    return [self rangeOfString:substring].location != NSNotFound;
}

@end
