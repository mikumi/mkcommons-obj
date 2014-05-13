//
//  MKUIHelper.h
//  checkintheair
//
//  Created by Michael Kuck on 4/30/14.
//  Copyright (c) 2014 Jaysquared. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIView;

//============================================================
//== Public Interface
//============================================================
@interface MKUIHelper : NSObject

+ (void)addMatchParentConstraintsToView:(UIView *)view parentView:(UIView *)parentView;
+ (void)addMatchParentConstraintsToView:(UIView *)view parentView:(UIView *)parentView distanceLeft:(NSInteger)left
                            distanceTop:(NSInteger)top distanceRight:(NSInteger)right distanceBottom:(NSInteger)bottom;
+ (void)addStayCenterConstraintsToView:(UIView *)view parentView:(UIView *)parentView;

@end
