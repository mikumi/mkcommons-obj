//
//  MKSerialManager.h
//  Ping Monitor
//
//  Created by Michael Kuck on 9/13/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKSerialManager : NSObject

- (NSString *)generateSerialForProduct:(NSString *)product
                            andFeature:(NSInteger)feature
                        withExpiryTime:(NSInteger)expiryTime;

- (BOOL)isSerialValid:(NSString *)serial
          forProduct:(NSString *)product
          forFeature:(NSInteger)feature;

@end
