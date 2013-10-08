//
//  MKVersion.h
//  MKCommons
//
//  Created by Michael Kuck on 9/27/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

extern NSString *const MKApplicationVersion(void);

extern NSUInteger const MAJOR;
extern NSUInteger const MINOR;
extern NSUInteger const PATCH;

NSUInteger const MAJOR = 1;
NSUInteger const MINOR = 0;
NSUInteger const PATCH = 6;

/*
 * ********************************
 * MKCommons Changelog
 * ********************************
 *
 * v1.0.6
 * - Small code cleanup
 *
 * v1.0.5
 * - Added isRunningOnIphone to MiscHelper
 * - Improved Test coverage (total over 90% now)
 * - Included build configration for coverage builds
 *
 * v1.0.4
 * - Updated test suite for MKPreferencesManager and MKSerialManager
 *
 * v1.0.3
 * - Added MKPreferencesManager class
 * - Make SerialManager methods static
 *
 * v1.0.2
 * - Added MKLog class
 * - Updated other classes to use MKLog
 *
 * v1.0.1
 * - Fixed copy headers build step to include all single headers for the different parts
 *
 * v1.0.0
 * - Initial commit containing: MKFallbackQueue, MKMiscHelper, MKSerialManager and MKStopwatch.
 */

