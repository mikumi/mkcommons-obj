//
//  MKItemListTableView.m
//  checkintheair
//
//  Created by Michael Kuck on 4/30/14.
//  Copyright (c) 2014 Jaysquared. All rights reserved.
//

#import "MKItemListView.h"

// Project Headers
#import "MKUIHelper.h"
#import "MKLog.h"

NS_ENUM(NSInteger, TableViewSection) {
    TableViewSectionHeader = 0,
    TableViewSectionItem = 1,
    TableViewSectionAddItem = 2,
    TableViewSectionFooter = 3,
    TableViewNumberOfSections = 4
};

static NSString *const CellIdentifierItemCell = @"itemCell";
static NSString *const CellIdentifierAddItemCell = @"addItemCell";

//============================================================
//== Private Interface
//============================================================
@interface MKItemListView () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic, readonly) UIView *viewForNewItemCell;

- (void)buttonActionNewItem:(id)sender;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKItemListView

@synthesize viewForNewItemCell = _viewForNewItemCell;

/*
 * (Inherited Comment)
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isEditable = YES;
        _isSelectable = YES;
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        _tableView.backgroundColor = self.backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [MKUIHelper addMatchParentConstraintsToView:self.tableView parentView:self];
    }
    return self;
}

/*
 * (Inherited Comment)
 */
- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, 0, 0)];
}

/**
 * Fill the parent view by adding constraints. Will auto resize if necessary.
 */
- (void)autoFillParentView
{
    [MKUIHelper addMatchParentConstraintsToView:self parentView:self.superview];
}

/**
 * // TODO: this method comment needs be updated.
 */
- (void)reload
{
    [self.tableView reloadData];
}

/*
 * (Inherited Comment)
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    [self.tableView setBackgroundColor:backgroundColor];
}

//=== UITableViewDataSource ===//
#pragma mark - UITableViewDataSource

/*
 * (Inherited Comment)
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == TableViewSectionItem) {
        if (self.delegate != nil) {
            count = (NSInteger)[self.delegate numberOfItemsInItemListView:self];
        }
    } else if (section == TableViewSectionAddItem) {
        if (self.isEditable) {
            count = 1;
        } else {
            count = 0;
        }
    }
    MKLogVerbose(@"Section %d rows: %d", section, count);
    return count;
}

/*
 * (Inherited Comment)
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Fix creating cell content. Check if already initialized etc
    UITableViewCell *cell;
    if (indexPath.section == TableViewSectionItem) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierItemCell];
        if (cell == nil) {
            MKLogDebug(@"Creating a %@...", CellIdentifierItemCell);
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                reuseIdentifier:CellIdentifierItemCell];
            cell.backgroundColor = [UIColor whiteColor];
            if (self.isSelectable) {
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            } else {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UIView *const itemView = [self.delegate itemViewForItemListView:self];
            [cell.contentView addSubview:itemView];
            [MKUIHelper addMatchParentConstraintsToView:itemView parentView:cell];
        } else {
            MKLogVerbose(@"Found a reusable %@...", CellIdentifierItemCell);
        }
        assert([cell.contentView.subviews count] == 1); // At this point the cell should always be properly initialized
        if ([self.delegate respondsToSelector:@selector(itemListView:updateContentForItem:view:)]) {
            UIView *const itemView = [cell.contentView.subviews lastObject];
            [self.delegate itemListView:self updateContentForItem:[indexPath row] view:itemView];
        }
    } else if (indexPath.section == TableViewSectionAddItem) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierAddItemCell];
        if (cell == nil) {
            MKLogDebug(@"Creating a %@...", CellIdentifierAddItemCell);
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifierAddItemCell];
            cell.backgroundColor = [UIColor clearColor];
            UIView *const newItemView = [self viewForNewItemCell];
            [cell.contentView addSubview:newItemView];
            [MKUIHelper addMatchParentConstraintsToView:newItemView parentView:cell];
        } else {
            MKLogVerbose(@"Found a reusable %@...", CellIdentifierAddItemCell);
        }
        assert([cell.contentView.subviews count] == 1); // At this point the cell should always be properly initialized
        
    }
    return cell;
}

/*
 * (Inherited Comment)
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TableViewNumberOfSections;
}

//=== UITableViewDelegate ===//
#pragma mark - UITableViewDelegate

/*
 * (Inherited Comment)
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    if ([indexPath section] == TableViewSectionItem) {
        if (self.delegate != nil) {
            height = (CGFloat)[self.delegate heightOfItemCellInItemListView:self];
        }
    } else {
        height = self.tableView.rowHeight;
    }
    return height;
}

/*
 * (Inherited Comment)
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSelectable) {
        if ([indexPath section] == TableViewSectionItem) {
            assert([indexPath row] >= 0);
            [self.delegate itemListView:self didSelectItem:(NSUInteger)[indexPath row]];
        } else if ([indexPath section] == TableViewSectionAddItem) {
            // Nothing to do
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//=== Private Implementation ===//
#pragma mark - Private Implementation

- (UIView *)viewForNewItemCell
{
    if (_viewForNewItemCell == nil) {
        UIView *const view = [[UIView alloc] init];
        
        UIButton *const addItemButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        NSString *title;
        if ([self.delegate respondsToSelector:@selector(titleForAddItemButtonInItemListView:)])
        {
            title = [self.delegate titleForAddItemButtonInItemListView:self];
        } else {
            title = @"New Item";
        }
        [addItemButton setTitle:title forState:UIControlStateNormal];
        [addItemButton setTintColor:[UIColor whiteColor]];
        [addItemButton addTarget:self action:@selector(buttonActionNewItem:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:addItemButton];
        [MKUIHelper addStayCenterConstraintsToView:addItemButton parentView:view];
        
        _viewForNewItemCell = view;
    }
    return _viewForNewItemCell;
}

/**
 * // TODO: this method comment needs be updated.
 */
- (void)buttonActionNewItem:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectAddItemInItemListView:)]) {
        [self.delegate didSelectAddItemInItemListView:self];
    }
}

@end
