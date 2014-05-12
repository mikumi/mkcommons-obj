//
//  MKFormTableViewCellTextField.h
//  MKCommons
//
//  Created by Michael Kuck on 5/12/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKFormTableViewCellTextField : UITableViewCell

@property (strong, nonatomic, readonly) UITextField *textField;

- (instancetype)initWithTextField:(UITextField *)textField;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier textField:(UITextField *)textField;

@end
