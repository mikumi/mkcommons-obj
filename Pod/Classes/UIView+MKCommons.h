//
//  UIView+MKConstraints.h
//  MKCommons
//
//  Created by Michael Kuck on 5/30/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MKCommons)

//=== Match parent constraints ===//
- (void)addConstraintsToMatchParentView:(UIView *)parentView;
- (void)addConstraintsToMatchParentView:(UIView *)parentView distanceLeft:(CGFloat)left distanceTop:(CGFloat)top
                          distanceRight:(CGFloat)right distanceBottom:(CGFloat)bottom;

//=== Stay center constraints ===//
- (void)addConstraintsToCenterWithinParentView:(UIView *)parentView;
- (void)addConstraintToCenterXWithinParentView:(UIView *)parentView;
- (void)addConstraintToCenterYWithinParentView:(UIView *)parentView;

//=== Align with view constraints ===//
- (void)addConstraintToAlignLeftWithView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView;
- (void)addConstraintToAlignRightWithView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView;
- (void)addConstraintToAlignTopWithView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView;
- (void)addConstraintToAlignBottomWithView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView;

//=== Stay left/right/bottom/top of constraints ===//
- (void)addConstraintToStayLeftOfView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView;
- (void)addConstraintToStayRightOfView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView;
- (void)addConstraintToStayAboveOfView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView;
- (void)addConstraintToStayBelowOfView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView;

//=== Size constraints ===//
- (void)addConstraintToFixWidth:(CGFloat)width parentView:(UIView *)parentView;
- (void)addConstraintToFixHeight:(CGFloat)height parentView:(UIView *)parentView;
- (void)addConstraintsToFixWidth:(CGFloat)width height:(CGFloat)height parentView:(UIView *)parentView;

//=== Reset ===//
- (void)removeAllConstraints;

//=== Other stuff
- (UIImage *)takeSnapshot;

@end
