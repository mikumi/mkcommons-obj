//
// Created by Michael Kuck on 5/15/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKFormTableViewCellDatePicker.h"
#import "UIView+MKConstraints.h"

//============================================================
//== Private Interface
//============================================================
@interface MKFormTableViewCellDatePicker ()

@end

//============================================================
//== Implementation
//============================================================
@implementation MKFormTableViewCellDatePicker
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
- (instancetype)initWithDatePicker:(UIDatePicker *)datePicker
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil datePicker:datePicker];
}

/*
 * (Inherited Comment)
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier datePicker:nil];
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
                   datePicker:(UIDatePicker *)datePicker;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (_datePicker == nil) {
            _datePicker = [[UIDatePicker alloc] init];
        } else {
            _datePicker = datePicker;
        }
        [self.contentView addSubview:_datePicker];
        [_datePicker addConstraintsToMatchParentView:self.contentView];
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