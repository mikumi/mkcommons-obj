//
//  MKFormTableViewCellTextField.m
//  MKCommons
//
//  Created by Michael Kuck on 5/12/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKFormTableViewCellTextField.h"
#import "UIView+MKCommons.h"

@implementation MKFormTableViewCellTextField

/*
 * (Inherited Comment)
 */
- (instancetype)init
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

/*
 * (Inherited Comment)
 */
- (instancetype)initWithTextField:(UITextField *)textField
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil textField:textField];
}

/*
 * (Inherited Comment)
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier textField:nil];
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
                    textField:(UITextField *)textField
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (textField == nil) {
            _textField = [[UITextField alloc] init];
        } else {
            _textField = textField;
        }
        [self.contentView addSubview:_textField];
        [_textField addConstraintsToMatchParentView:self.contentView distanceLeft:20 distanceTop:6 distanceRight:20
                                     distanceBottom:6];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
