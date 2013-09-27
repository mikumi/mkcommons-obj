//
//  MKVersion.m
//  MKCommons
//
//  Created by Michael Kuck on 9/27/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKVersion.h"

NSString *const APPLICATION_VERSION(void) {
    NSString *version = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)MAJOR, (long)MINOR, (long)PATCH];
    return version;
}
