//
//  MKFormTableViewCellSeparator.m
//  MKCommons
//
//  Created by Michael Kuck on 5/12/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKFormTableViewCellSeparator.h"
#import "UIColor+MKCommons.h"

@implementation MKFormTableViewCellSeparator

/*
 * (Inherited Comment)
 */
- (instancetype)init
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor veryLightGray];
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
