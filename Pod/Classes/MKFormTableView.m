//
//  MKFormTableView.m
//  MKCommons
//
//  Created by Michael Kuck on 5/12/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKFormTableView.h"

#import "MKLog.h"
#import "MKSystemHelper.h"
#import "MKFormTableViewCellInfo.h"
#import "MKFormTableViewCellButton.h"
#import "MKFormTableViewCellDatePicker.h"

@interface MKFormTableView ()<UITableViewDataSource, UITableViewDelegate>

- (void)didTouchOutside:(id)sender;
- (UITapGestureRecognizer *)newTapGestureRecognizer;

@end

@implementation MKFormTableView

/*
 * (Inherited Comment)
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeInstance];
    }
    return self;
}

/*
 * (Inherited Comment)
 */
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initializeInstance];
    }
    return self;
}

/*
 * (Inherited Comment)
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeInstance];
    }
    return self;
}

/**
* Initializes instance. Should be called from both initWithCoder and initWithNibName (or others as appropriate), as
* we don't know which one will be called.
*/
- (void)initializeInstance
{
    MKLogDebug(@"Initializing instance...");
    self.delegate        = self;
    self.dataSource      = self;
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _cells = [[NSArray alloc] init];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)setCells:(NSArray *)cells
{
    _cells = cells;
    [self reloadData];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (UILabel *)addInfoCellWithText:(NSString *)text
{
    MKFormTableViewCellInfo *const infoCell = [[MKFormTableViewCellInfo alloc] initWithText:text];
    [infoCell addGestureRecognizer:[self newTapGestureRecognizer]];
    [infoCell.label addGestureRecognizer:[self newTapGestureRecognizer]];
    self.cells = [self.cells arrayByAddingObject:infoCell];
    return infoCell.label;

}

/**
* // DOCU: this method comment needs be updated.
*/
- (UIButton *)addButtonCellWithTitle:(NSString *)title
{
    MKFormTableViewCellButton *const buttonCell = [[MKFormTableViewCellButton alloc] initWithTitle:title];
    [buttonCell addGestureRecognizer:[self newTapGestureRecognizer]];
    self.cells = [self.cells arrayByAddingObject:buttonCell];
    return buttonCell.button;

}

/**
* // DOCU: this method comment needs be updated.
*/
- (UITextField *)addTextFieldCell
{
    UITextField *const textField = [[UITextField alloc] init];
    return [self addCustomTextFieldCellWithTextField:textField];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (UITextField *)addCustomTextFieldCellWithTextField:(UITextField *)textField
{
    MKFormTableViewCellTextField *const textFieldCell = [[MKFormTableViewCellTextField alloc]
            initWithTextField:textField];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    self.cells = [self.cells arrayByAddingObject:textFieldCell];
    return textFieldCell.textField;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addSeparatorCell
{
    MKFormTableViewCellSeparator *const separatorCell = [[MKFormTableViewCellSeparator alloc] init];
    [separatorCell addGestureRecognizer:[self newTapGestureRecognizer]];
    self.cells = [self.cells arrayByAddingObject:separatorCell];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (UITableViewCell *)addCustomCell
{
    MKFormTableViewCellSeparator *const separatorCell = [[MKFormTableViewCellSeparator alloc] init];
    [separatorCell addGestureRecognizer:[self newTapGestureRecognizer]];
    self.cells           = [self.cells arrayByAddingObject:separatorCell];
    self.backgroundColor = [UIColor whiteColor];
    return separatorCell;
}

/**
* // DOCU: this method comment needs be updated.
*/
- (UIDatePicker *)addDatePickerCell
{
    MKFormTableViewCellDatePicker *const datePickerCell = [[MKFormTableViewCellDatePicker alloc] init];
    datePickerCell.datePicker.backgroundColor = [UIColor whiteColor];
    self.cells                                = [self.cells arrayByAddingObject:datePickerCell];
    return datePickerCell.datePicker;
}

/*
 * (Inherited Comment)
 */
- (void)setCellAtRow:(NSUInteger)row hidden:(BOOL)hidden
{
    if (row < [self.cells count]) {
        UITableViewCell *const cell = self.cells[row];
        [self beginUpdates];
        [cell setHidden:hidden];
        [self endUpdates];
    }
}

//=== UITableViewDataSource ===//
#pragma mark - UITableViewDataSource

/*
 * (Inherited Comment)
 */
- (NSInteger)numberOfSections
{
    return 1;
}

/*
 * (Inherited Comment)
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cells count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([[self.cells objectAtIndex:[indexPath row]] isKindOfClass:[MKFormTableViewCellDatePicker class]]) {
//        return 162;
//    } else {
//        return self.rowHeight;
//    }
//}

/*
 * (Inherited Comment)
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *const cell = self.cells[(NSUInteger)[indexPath row]];
    if ([indexPath row] + 1 < [self.cells count]) { // make sure there actually exists a next cell
        UITableViewCell *const nextCell = self.cells[(NSUInteger)([indexPath row] + 1)];
        // No inset (=full line) between content cells and separator cells
        if ((([cell isKindOfClass:[MKFormTableViewCellSeparator class]]) &&
             (![nextCell isKindOfClass:[MKFormTableViewCellSeparator class]])) ||
            ((![cell isKindOfClass:[MKFormTableViewCellSeparator class]]) &&
             ([nextCell isKindOfClass:[MKFormTableViewCellSeparator class]]))) {
            cell.separatorInset = UIEdgeInsetsZero;
        } else if (([cell isKindOfClass:[MKFormTableViewCellSeparator class]]) &&
                   ([nextCell isKindOfClass:[MKFormTableViewCellSeparator class]])) {
            cell.separatorInset = UIEdgeInsetsMake(0, self.frame.size.width, 0, 0);
        }
    } else { // if last cell
        cell.separatorInset = UIEdgeInsetsMake(0, self.frame.size.width, 0, 0);
    }
    return cell;
}

//=== Private Implementation ===//
#pragma mark - Private Implementation

/**
* // DOCU: this method comment needs be updated.
*/
- (void)didTouchOutside:(id)sender
{
    [self endEditing:YES];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (UITapGestureRecognizer *)newTapGestureRecognizer;
{
    UITapGestureRecognizer *const tapGestureRecognizer = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(didTouchOutside:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    return tapGestureRecognizer;
}

@end
