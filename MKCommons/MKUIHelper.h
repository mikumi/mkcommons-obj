//
//  MKUIHelper.h
//  checkintheair
//
//  Created by Michael Kuck on 4/30/14.
//  Copyright (c) 2014 Jaysquared. All rights reserved.
//

#import <Foundation/Foundation.h>

//============================================================
//== Public Interface
//============================================================
@interface MKUIHelper : NSObject

+ (void)addMatchParentConstraintsForView:(UIView *)view parentView:(UIView *)parentView;
+ (void)addMatchParentConstraintsForView:(UIView *)view parentView:(UIView *)parentView distanceLeft:(CGFloat)left
                             distanceTop:(CGFloat)top distanceRight:(CGFloat)right distanceBottom:(CGFloat)bottom;
+ (void)addStayCenterConstraintsForView:(UIView *)view parentView:(UIView *)parentView;

+ (void)addCenterXConstraintForView:(UIView *)view parentView:(UIView *)parentView;
+ (void)addCenterYConstraintForView:(UIView *)view parentView:(UIView *)parentView;
+ (void)addConstraintForView:(UIView *)view distanceLeft:(CGFloat)left toView:(UIView *)leftView parentView:(UIView *)parentView;
+ (void)addConstraintForView:(UIView *)view distanceRight:(CGFloat)right toView:(UIView *)rightView parentView:(UIView *)parentView;
+ (void)addConstraintForView:(UIView *)view distanceTop:(CGFloat)top toView:(UIView *)topView parentView:(UIView *)parentView;
+ (void)addConstraintForView:(UIView *)view distanceBottom:(CGFloat)bottom toView:(UIView *)bottomView parentView:(UIView *)parentView;

@end
