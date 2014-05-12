//
//  MKUIHelper.m
//  checkintheair
//
//  Created by Michael Kuck on 4/30/14.
//  Copyright (c) 2014 Jaysquared. All rights reserved.
//

#import "MKUIHelper.h"

// Framework Headers
#import <UIKit/UIKit.h>

@implementation MKUIHelper

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addMatchParentConstraintsToView:(UIView *)view parentView:(UIView *)parentView
{
    [self addMatchParentConstraintsToView:view parentView:parentView distanceLeft:0 distanceTop:0 distanceRight:0 distanceBottom:0];
}

+ (void)addMatchParentConstraintsToView:(UIView *)view
                             parentView:(UIView *)parentView
                           distanceLeft:(NSInteger)left
                            distanceTop:(NSInteger)top
                          distanceRight:(NSInteger)right
                         distanceBottom:(NSInteger)bottom
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:top]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:left]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:bottom]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:right]];
}

/**
 * // TODO: this method comment needs be updated.
 */
+ (void)addStayCenterConstraintsToView:(UIView *)view parentView:(UIView *)parentView
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

@end
