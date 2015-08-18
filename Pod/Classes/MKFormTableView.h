//
//  MKFormTableView.h
//  MKCommons
//
//  Created by Michael Kuck on 5/12/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKFormTableViewCellSeparator.h"
#import "MKFormTableViewCellTextField.h"

@interface MKFormTableView : UITableView

@property (strong, nonatomic) NSArray *cells;

- (void)addSeparatorCell;
- (UITableViewCell *)addCustomCell;
- (UITextField *)addTextFieldCell;
- (UITextField *)addCustomTextFieldCellWithTextField:(UITextField *)textField;
- (UILabel *)addInfoCellWithText:(NSString *)text;
- (UIButton *)addButtonCellWithTitle:(NSString *)title;
- (UIDatePicker *)addDatePickerCell;
- (void)setCellAtRow:(NSUInteger)row hidden:(BOOL)hidden;

@end
