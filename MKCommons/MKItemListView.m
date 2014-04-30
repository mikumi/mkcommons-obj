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
    TableViewSectionItem = 0,
    TableViewSectionAddItem = 1,
    TableViewNumberOfSections = 2
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
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [MKUIHelper addMatchParentConstraintsToView:self.tableView parentView:self];
        
        self.backgroundColor = [UIColor clearColor];
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
        count = 1;
    }
    MKLogVerbose(@"Section %d rows: %d", section, count);
    return count;
}

/*
 * (Inherited Comment)
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == TableViewSectionItem) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierItemCell];
        if (cell == nil) {
            MKLogDebug(@"Creating a %@...", CellIdentifierItemCell);
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                reuseIdentifier:CellIdentifierItemCell];
        } else {
            MKLogVerbose(@"Found a reusable %@...", CellIdentifierItemCell);
        }
        cell.backgroundColor = [UIColor clearColor];
        UIView *itemView = [self.delegate itemViewForItemListView:self];
        [cell addSubview:itemView];
        [MKUIHelper addMatchParentConstraintsToView:itemView parentView:cell];
    } else if (indexPath.section == TableViewSectionAddItem) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierAddItemCell];
        if (cell == nil) {
            MKLogDebug(@"Creating a %@...", CellIdentifierAddItemCell);
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifierAddItemCell];
        } else {
            MKLogVerbose(@"Found a reusable %@...", CellIdentifierAddItemCell);
        }
        cell.backgroundColor = [UIColor clearColor];
        UIView *newItemView = [self viewForNewItemCell];
        [cell addSubview:newItemView];
        [MKUIHelper addMatchParentConstraintsToView:newItemView parentView:cell];
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
    if ([indexPath section] == TableViewSectionItem) {
        assert([indexPath row] >= 0);
        [self.delegate itemListView:self didSelectItem:(NSUInteger)[indexPath row]];
    } else if ([indexPath section] == TableViewSectionAddItem) {
        // Nothing to do
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//=== Private Implementation ===//
#pragma mark - Private Implementation

- (UIView *)viewForNewItemCell
{
    if (_viewForNewItemCell == nil) {
        UIView *view = [[UIView alloc] init];
        
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
    [self.delegate didSelectAddItemInItemListView:self];
}

@end
