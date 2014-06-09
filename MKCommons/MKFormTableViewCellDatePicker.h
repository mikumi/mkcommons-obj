//
// Created by Michael Kuck on 5/15/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <UIKit/UIKit.h>

//============================================================
//== Public Interface
//============================================================
@interface MKFormTableViewCellDatePicker : UITableViewCell

@property (strong, nonatomic, readonly) UIDatePicker *datePicker;

- (instancetype)initWithDatePicker:(UIDatePicker *)datePicker;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
                    datePicker:(UIDatePicker *)datePicker;

@end