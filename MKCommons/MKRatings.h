//
//  MKRatings.h
//  Ping Monitor
//
//  Created by Michael Kuck on 11/10/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKRatings : NSObject

- (void)recordEventAppOpened;
- (void)showPopupIfRequirementsMatch;

@end
