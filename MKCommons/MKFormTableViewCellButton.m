//
//  MKFormTableViewCellButton.m
//  MKCommons
//
//  Created by Michael Kuck on 5/13/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKFormTableViewCellButton.h"
#import "MKUIHelper.h"
#import "MKUIColors.h"

//============================================================
//== Private Interface
//============================================================
@interface MKFormTableViewCellButton ()

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title;
@end

//============================================================
//== Implementation
//============================================================
@implementation MKFormTableViewCellButton

/*
* (Inherited Comment)
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier title:@""];
}

/*
 * (Inherited Comment)
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _button = [[UIButton alloc] init];
        [_button setTitle:title forState:UIControlStateNormal];
        [_button setTitleColor:[MKUIColors mediumBlue] forState:UIControlStateNormal];
        [_button setTitleColor:[MKUIColors lightBlue] forState:UIControlStateSelected];
        [_button setTitleColor:[MKUIColors lightBlue] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_button];
        [MKUIHelper addStayCenterConstraintsForView:_button parentView:self.contentView];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

/**
 * // TODO: this method comment needs be updated.
 */
- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil
                         title:title];
}

@end
