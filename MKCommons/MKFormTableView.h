//
//  MKFormTableView.h
//  MKCommons
//
//  Created by Michael Kuck on 5/12/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKFormTableViewCellSeparator.h"
#import "MKFormTableViewCellTextField.h"

@interface MKFormTableView : UITableView

@property (strong, nonatomic) NSArray *cells;

- (UITextField *)addTextFieldCell;
- (UITextField *)addCustomTextFieldCellWithTextField:(UITextField *)textField;
- (void)addSeparatorCell;
- (void)addInfoCellWithText:(NSString *)text;

@end
