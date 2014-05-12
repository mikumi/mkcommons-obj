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

@interface MKFormTableView () <UITableViewDataSource, UITableViewDelegate>

- (void)didTouchOutside:(id)sender;

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
    MKLogVerbose(@"Initializing instance...");
    self.delegate = self;
    self.dataSource = self;
    _cells = [[NSArray alloc] init];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (void)setCells:(NSArray *)cells
{
    _cells = cells;
    [self reloadData];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (UITextField *)addTextFieldCell
{
    UITextField *textField = [[UITextField alloc] init];
    return [self addCustomTextFieldCellWithTextField:textField];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (UITextField *)addCustomTextFieldCellWithTextField:(UITextField *)textField
{
    MKFormTableViewCellTextField *textFieldCell = [[MKFormTableViewCellTextField alloc]
            initWithTextField:textField];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    self.cells = [self.cells arrayByAddingObject:textFieldCell];
    return textFieldCell.textField;
}

/**
 * // TODO: this method comment needs be updated.
 */
- (void)addSeparatorCell
{
    MKFormTableViewCellSeparator *separatorCell = [[MKFormTableViewCellSeparator alloc] init];

    //=== Resign first responder when touch up outside ===//
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(didTouchOutside:)];
    tap.cancelsTouchesInView = NO;
    [separatorCell addGestureRecognizer:tap];

    self.cells = [self.cells arrayByAddingObject:separatorCell];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (void)addInfoCellWithText:(NSString *)text
{
    // TODO: implement
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

/*
 * (Inherited Comment)
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.cells objectAtIndex:[indexPath row]];
    if ([indexPath row] + 1 < [self.cells count]) {
        UITableViewCell *nextCell = [self.cells objectAtIndex:([indexPath row] + 1)];
        // No inset (=full line) between content cells and separator cells
        if ((([cell isKindOfClass:[MKFormTableViewCellSeparator class]]) &&
             (![nextCell isKindOfClass:[MKFormTableViewCellSeparator class]])) ||
            ((![cell isKindOfClass:[MKFormTableViewCellSeparator class]]) &&
             ([nextCell isKindOfClass:[MKFormTableViewCellSeparator class]]))) {
            if ([MKSystemHelper isLegacyPlatform]) {
                // TODO: implement
            } else {
                cell.separatorInset = UIEdgeInsetsZero;
            }
        }
    }
    return cell;
}

//=== UITableViewDelegate ===//
#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    return [[UIView alloc] init];
}

//=== Private Implementation ===//
#pragma mark - Private Implementation

/**
 * // TODO: this method comment needs be updated.
 */
- (void)didTouchOutside:(id)sender
{
    [self endEditing:YES];
}

@end
