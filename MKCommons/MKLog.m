//
//  MKLog.m
//  MKCommons
//
//  Created by Michael Kuck on 9/30/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKLog.h"

static MKLogLevel _logLevel = MKLogLevelWarning;

/**
 * Set the global logging level
 *
 * @param logLevel The maximum MKLogLevel for messages (lower level messages are more important). 0 is nothing.
 */
void MKSetLogLevel(MKLogLevel logLevel) {
    _logLevel = logLevel;
}

/**
 * Get the global logging level
 *
 * @return MKLogLevel. 0 is nothing.
 */
MKLogLevel MKGetCurrentLogLevel() {
    return _logLevel;
}