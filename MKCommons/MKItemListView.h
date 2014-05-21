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

@required
- (NSUInteger)numberOfItemsInItemListView:(MKItemListView *)itemListView;
- (CGFloat)heightOfItemCellInItemListView:(MKItemListView *)itemListView;
- (UIView *)itemViewForItemListView:(MKItemListView *)itemListView;
- (void)itemListView:(MKItemListView *)itemListView updateContentForItem:(NSUInteger)itemNumber view:(UIView *)itemView;

@optional
- (NSString *)titleForAddItemButtonInItemListView:(MKItemListView *)itemListView;
- (void)itemListView:(MKItemListView *)itemListView didSelectItem:(NSUInteger)itemNumber;
- (void)didSelectAddItemInItemListView:(MKItemListView *)itemListView;
- (void)itemListView:(MKItemListView *)itemListView didRemoveItem:(NSUInteger)itemNumber;

@end

//============================================================
//== Public Interface
//============================================================
@interface MKItemListView : UIView

@property (strong, nonatomic, readonly) UITableView *tableView; // TODO: think about making it private
@property (strong, nonatomic) id <MKItemListViewDelegate> delegate;
@property (assign, nonatomic) BOOL isEditable;
@property (assign, nonatomic) BOOL isSelectable;

- (void)autoFillParentView;

- (void)reload;

@end
