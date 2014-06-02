//
//  MKFormTableViewCellInfo.m
//  MKCommons
//
//  Created by Michael Kuck on 5/12/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKFormTableViewCellInfo.h"
#import "UIColor+MKCommons.h"
#import "UIView+MKConstraints.h"

//============================================================
//== Private Interface
//============================================================
@interface MKFormTableViewCellInfo ()

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKFormTableViewCellInfo

/*
 * (Inherited Comment)
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier text:@""];
}

/*
 * (Inherited Comment)
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text          = text;
        _label.font          = [_label.font fontWithSize:10];
        _label.numberOfLines = 2;
        [_label setTextColor:[UIColor mediumGray]];
        [self.contentView addSubview:_label];
        [_label addConstraintsToMatchParentView:self.contentView distanceLeft:20 distanceTop:6 distanceRight:20
                                 distanceBottom:6];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

/**
 * // TODO: this method comment needs be updated.
 */
- (instancetype)initWithText:(NSString *)text
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil
                          text:text];
}

@end
