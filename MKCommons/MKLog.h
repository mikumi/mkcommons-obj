//
//  MKLog.h
//  MKCommons
//
//  Created by Michael Kuck on 9/30/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MKLogLevel) {
    MKLogLevelNone = 0,
    MKLogLevelError = 1,
    MKLogLevelWarning = 2,
    MKLogLevelInfo = 3,
    MKLogLevelVerbose = 4
};

extern void MKSetLogLevel(MKLogLevel logLevel);
extern MKLogLevel MKGetCurrentLogLevel();

#define MKLogError(message, ...) { \
                                        if (MKGetCurrentLogLevel() >= MKLogLevelError) { \
                                        NSLog(@"[ERROR] <%@:%u> %@", NSStringFromClass([self class]), __LINE__, [NSString stringWithFormat:(message), ##__VA_ARGS__]); \
                                        } \
                                    }

#define MKLogWarning(message, ...) { \
                                        if (MKGetCurrentLogLevel() >= MKLogLevelWarning) { \
                                        NSLog(@"[WARNING] <%@:%u> %@", NSStringFromClass([self class]), __LINE__, [NSString stringWithFormat:(message), ##__VA_ARGS__]); \
                                        } \
                                    }

#define MKLogInfo(message, ...) { \
                                        if (MKGetCurrentLogLevel() >= MKLogLevelInfo) { \
                                        NSLog(@"<%@:%u> %@", NSStringFromClass([self class]), __LINE__, [NSString stringWithFormat:(message), ##__VA_ARGS__]); \
                                        } \
                                    }

#define MKLogVerbose(message, ...) { \
                                        if (MKGetCurrentLogLevel() >= MKLogLevelVerbose) { \
                                        NSLog(@"<%@:%u> %@", NSStringFromClass([self class]), __LINE__, [NSString stringWithFormat:(message), ##__VA_ARGS__]); \
                                        } \
                                    }


