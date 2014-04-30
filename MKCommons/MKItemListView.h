//
//  MKItemListTableView.h
//  checkintheair
//
//  Created by Michael Kuck on 4/30/14.
//  Copyright (c) 2014 Jaysquared. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKItemListView;

@protocol MKItemListViewDelegate <NSObject>

- (NSUInteger)numberOfItemsInItemListView:(MKItemListView *)itemListView;
- (CGFloat)heightOfItemCellInItemListView:(MKItemListView *)itemListView;
- (void)itemListView:(MKItemListView *)itemListView didSelectItem:(NSUInteger)itemNumber;
- (void)didSelectAddItemInItemListView:(MKItemListView *)itemListView;
- (UIView *)itemViewForItemListView:(MKItemListView *)itemListView;

@end

//============================================================
//== Public Interface
//============================================================
@interface MKItemListView : UIView

@property (strong, nonatomic, readonly) UITableView *tableView;
@property (strong, nonatomic) id<MKItemListViewDelegate> delegate;

- (void)autoFillParentView;

@end
