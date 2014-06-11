//
//  UIView+MKConstraints.m
//  MKCommons
//
//  Created by Michael Kuck on 5/30/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "UIView+MKConstraints.h"

@implementation UIView (MKConstraints)

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintsToMatchParentView:(UIView *)parentView
{
    [self addConstraintsToMatchParentView:parentView distanceLeft:0 distanceTop:0 distanceRight:0 distanceBottom:0];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintsToMatchParentView:(UIView *)parentView distanceLeft:(CGFloat)left distanceTop:(CGFloat)top
                          distanceRight:(CGFloat)right distanceBottom:(CGFloat)bottom
{
    [self addConstraintToAlignTopWithView:parentView distance:top parentView:parentView];
    [self addConstraintToAlignLeftWithView:parentView distance:left parentView:parentView];
    [self addConstraintToAlignBottomWithView:parentView distance:bottom parentView:parentView];
    [self addConstraintToAlignRightWithView:parentView distance:right parentView:parentView];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintsToCenterWithinParentView:(UIView *)parentView
{
    [self addConstraintToCenterXWithinParentView:parentView];
    [self addConstraintToCenterYWithinParentView:parentView];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToCenterXWithinParentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeCenterX multiplier:1.0
                                                            constant:0]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToCenterYWithinParentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY
                                                           relatedBy:NSLayoutRelationEqual toItem:parentView
                                                           attribute:NSLayoutAttributeCenterY multiplier:1.0
                                                            constant:0]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToAlignLeftWithView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual toItem:view
                                                           attribute:NSLayoutAttributeLeft multiplier:1.0
                                                            constant:distance]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToAlignRightWithView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual toItem:view
                                                           attribute:NSLayoutAttributeRight multiplier:1.0
                                                            constant:-distance]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToAlignTopWithView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual toItem:view
                                                           attribute:NSLayoutAttributeTop multiplier:1.0
                                                            constant:distance]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToAlignBottomWithView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual toItem:view
                                                           attribute:NSLayoutAttributeBottom multiplier:1.0
                                                            constant:-distance]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToStayLeftOfView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual toItem:view
                                                           attribute:NSLayoutAttributeLeft multiplier:1.0
                                                            constant:-distance]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToStayRightOfView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual toItem:view
                                                           attribute:NSLayoutAttributeRight multiplier:1.0
                                                            constant:distance]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToStayAboveOfView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual toItem:view
                                                           attribute:NSLayoutAttributeTop multiplier:1.0
                                                            constant:-distance]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToStayBelowOfView:(UIView *)view distance:(CGFloat)distance parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual toItem:view
                                                           attribute:NSLayoutAttributeBottom multiplier:1.0
                                                            constant:distance]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToFixWidth:(CGFloat)width parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0
                                                            constant:width]];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addConstraintToFixHeight:(CGFloat)height parentView:(UIView *)parentView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0
                                                            constant:height]];
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)addConstraintsToFixWidth:(CGFloat)width height:(CGFloat)height parentView:(UIView *)parentView
{
    [self addConstraintToFixWidth:width parentView:parentView];
    [self addConstraintToFixHeight:height parentView:parentView];
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)removeAllConstraints
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self removeConstraints:self.constraints];
}

@end
