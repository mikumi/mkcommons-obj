//
//  MKVersion.h
//  MKCommons
//
//  Created by Michael Kuck on 9/27/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

extern NSString *const APPLICATION_VERSION(void);

extern NSUInteger const MAJOR;
extern NSUInteger const MINOR;
extern NSUInteger const PATCH;

NSUInteger const MAJOR = 1;
NSUInteger const MINOR = 0;
NSUInteger const PATCH = 1;

/*
 * ********************************
 * MKCommons Changelog
 * ********************************
 *
 * v1.0.1
 * - Fixed copy headers build step to include all single headers for the different parts
 *
 * v1.0.0
 * - Initial commit containing: MKFallbackQueue, MKMiscHelper, MKSerialManager and MKStopwatch.
 */

