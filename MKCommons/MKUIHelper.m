//
//  MKUIHelper.m
//  checkintheair
//
//  Created by Michael Kuck on 4/30/14.
//  Copyright (c) 2014 Jaysquared. All rights reserved.
//

#import "MKUIHelper.h"

@implementation MKUIHelper

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addMatchParentConstraintsForView:(UIView *)view parentView:(UIView *)parentView
{
    [self addMatchParentConstraintsForView:view parentView:parentView distanceLeft:0 distanceTop:0 distanceRight:0
                            distanceBottom:0];
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addMatchParentConstraintsForView:(UIView *)view parentView:(UIView *)parentView distanceLeft:(CGFloat)left
                             distanceTop:(CGFloat)top distanceRight:(CGFloat)right distanceBottom:(CGFloat)bottom
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeTop multiplier:1.0 constant:top]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeLeft multiplier:1.0
                                                            constant:left]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeBottom multiplier:1.0
                                                            constant:bottom]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeRight multiplier:1.0
                                                            constant:right]];
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addStayCenterConstraintsForView:(UIView *)view parentView:(UIView *)parentView
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeCenterX multiplier:1.0
                                                            constant:0]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeCenterY multiplier:1.0
                                                            constant:0]];
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addCenterXConstraintForView:(UIView *)view parentView:(UIView *)parentView
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeCenterX multiplier:1.0
                                                            constant:0]];
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addCenterYConstraintForView:(UIView *)view parentView:(UIView *)parentView
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeCenterY multiplier:1.0
                                                            constant:0]];
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addConstraintForView:(UIView *)view distanceLeft:(CGFloat)left toView:(UIView *)leftView
                  parentView:(UIView *)parentView
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual toItem:leftView
                                                           attribute:NSLayoutAttributeLeft multiplier:1.0
                                                            constant:left]];
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addConstraintForView:(UIView *)view distanceRight:(CGFloat)right toView:(UIView *)rightView
                  parentView:(UIView *)parentView
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual toItem:rightView
                                                           attribute:NSLayoutAttributeRight multiplier:1.0
                                                            constant:right]];
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addConstraintForView:(UIView *)view distanceTop:(CGFloat)top toView:(UIView *)topView
                  parentView:(UIView *)parentView
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual toItem:topView
                                                           attribute:NSLayoutAttributeTop multiplier:1.0 constant:top]];
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addConstraintForView:(UIView *)view distanceBottom:(CGFloat)bottom toView:(UIView *)bottomView
                  parentView:(UIView *)parentView
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual toItem:bottomView
                                                           attribute:NSLayoutAttributeBottom multiplier:1.0
                                                            constant:bottom]];
}

@end
