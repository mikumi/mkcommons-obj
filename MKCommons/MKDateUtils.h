//
//  MKDateUtils.h
//  MKCommons
//
//  Created by Michael Kuck on 5/19/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKDateUtils : NSObject

+ (NSDate *)dateByCopyingTimeComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSDate *)dateByCopyingDateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSDate *)removeTimeComponentsFromDate:(NSDate *)date;

@end
