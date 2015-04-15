//
//  UIImage+MKCommons.m
//  MKCommons
//
//  Created by Michael Kuck on 6/29/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "UIImage+MKCommons.h"

//============================================================
//== Implementation
//============================================================
@implementation UIImage (MKCommons)

/**
* // DOCU: this method comment needs be updated.
*/
+ (UIImage *)imageWithColor:(CGColorRef)color size:(CGSize)size
{
    CGRect const rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef const context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, color);
    CGContextFillRect(context, rect);

    UIImage *const image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
