//
//  MKSerialManager.m
//  Ping Monitor
//
//  Created by Michael Kuck on 9/13/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKSerialManager.h"

NSInteger const PRIME = 701;

@interface MKSerialManager ()

- (NSInteger)simpleChecksum:(long long)input;

@end

@implementation MKSerialManager

/*
 Expiring Promo Codes:
 PP = Product Prefix (e.g. PM for Ping Monitor)
 RR = Randomly generated number
 FF = product/featureID (e.g. 01)
 YYYYYYY = expiry timestamp in hours (since epoch)
 RRFFYYYYYYYCCC (+3 digit checksum)
 PMZZZZZZZZZZZZZZZZZ ->  (x 3 digit prime)
 Add dashes: PMZZZZ-ZZZZ-ZZZZ-ZZZZZ
 
 */

- (NSString *)generateSerialForProduct:(NSString *)product
                           andFeature:(NSInteger)feature
                            withExpiryTime:(NSInteger)expiryTime;
{
    // serial prefix: product
    NSString *serial = [product substringToIndex:2];
    
    // calculate expiry timestamp
    NSInteger expiryTimeInHoursSinceEpoch = (NSInteger)[[NSDate date] timeIntervalSince1970] / 60 / 60 + expiryTime;
    NSInteger random = arc4random() % 100;
    
    // Start with random number at the front
    
    
    
    // append feature and expiry time: RRFFYYYYYYY
    NSString *beforeEncryption = [NSString stringWithFormat:@"%02ld%02ld%07ld", (long)random, (long)feature, (long)expiryTimeInHoursSinceEpoch];
    
    // calculate checksum and append: FFYYYYYYYCCC
    NSInteger checksum = [self simpleChecksum:[beforeEncryption longLongValue]];
    beforeEncryption = [beforeEncryption stringByAppendingString:[NSString stringWithFormat:@"%03ld", (long)checksum]];
    
    // "Encrypt" with PRIME
    long long encrypted = [beforeEncryption longLongValue] * PRIME;
//    NSLog(@"%lld", [beforeEncryption longLongValue]);
    
    // Add dashes and append to serial
    NSMutableString *withDashes = [NSMutableString stringWithFormat:@"%017lld", encrypted];
    [withDashes insertString:@"-" atIndex:12];
    [withDashes insertString:@"-" atIndex:8];
    [withDashes insertString:@"-" atIndex:4];
    serial = [serial stringByAppendingString:withDashes];
    
    return serial;
}

- (BOOL)isSerialValid:(NSString *)serial
          forProduct:(NSString *)product
          forFeature:(NSInteger)feature;
{
    if ([serial length] < 22) {
        return NO;
    }
    NSMutableString *mutableSerial = [NSMutableString stringWithFormat:@"%@", serial];
    [mutableSerial deleteCharactersInRange:NSMakeRange(0, 2)];
    
    [mutableSerial deleteCharactersInRange:NSMakeRange(14, 1)];
    [mutableSerial deleteCharactersInRange:NSMakeRange(9, 1)];
    [mutableSerial deleteCharactersInRange:NSMakeRange(4, 1)];
    
    NSString *decryptedSerial = [NSString stringWithFormat:@"%014lld", [mutableSerial longLongValue] / PRIME];
//    NSLog(@"decryptedSerial: %@", decryptedSerial);
    
    NSInteger decryptedRandom = [[decryptedSerial substringWithRange:NSMakeRange(0, 2)] integerValue];
    NSInteger decryptedFeature = [[decryptedSerial substringWithRange:NSMakeRange(2, 2)] integerValue];
    NSInteger decryptedExpiryTime = [[decryptedSerial substringWithRange:NSMakeRange(4, 7)] integerValue];
    NSInteger decryptedChecksum = [[decryptedSerial substringWithRange:NSMakeRange(11, 3)] integerValue];
    
//    NSLog(@"random: %02d", decryptedRandom);
//    NSLog(@"feature: %02d", decryptedFeature);
//    NSLog(@"expiryTime: %07d", decryptedExpiryTime);
//    NSLog(@"checksum: %02d", decryptedChecksum);
    
    NSString *forChecksum = [NSString stringWithFormat:@"%02ld%02ld%07ld", (long)decryptedRandom, (long)decryptedFeature, (long)decryptedExpiryTime];
    NSInteger calculatedChecksum = [self simpleChecksum:[forChecksum longLongValue]];
    
    NSInteger currentTimeInHoursSinceEpoch = (NSInteger)[[NSDate date] timeIntervalSince1970] / 60 / 60;
    
    if (decryptedChecksum != calculatedChecksum) {
        return NO;
    } else if (currentTimeInHoursSinceEpoch > decryptedExpiryTime) {
        return NO;
    } else {
        return YES;
    }
}

- (NSInteger)simpleChecksum:(long long)input {
    NSString *inputString = [NSString stringWithFormat:@"%lld", input];
    NSInteger checksum = 0;
    for (NSUInteger i = 0; i < [inputString length]; i++) {
        NSInteger digit = [inputString characterAtIndex:i] - 48;
        checksum += pow(digit + 1, 2);
    }
    checksum = checksum % 997;
    return checksum;
}

@end
