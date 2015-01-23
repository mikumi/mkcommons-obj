//
// Created by Michael Kuck on 8/20/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKDragDropTableView.h"

#import "MKLog.h"
#import "UIView+MKCommons.h"

//============================================================
//== Private Interface
//============================================================
@interface MKDragDropTableView ()

@property (nonatomic, weak) UITableViewCell *draggedCell;
@property (nonatomic, strong) UIImageView   *cellSnapshotView;
@property (nonatomic, assign) CGPoint       previousTouchLocation;

- (void)initializeInstance;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKDragDropTableView

//=== Life cycle ===//
#pragma mark - Life cycle

- (id)init
{
    self = [super init];
    if (self) {
        [self initializeInstance];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initializeInstance];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeInstance];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
    UIGestureRecognizer *const longPressRecognizer = [[UILongPressGestureRecognizer alloc]
            initWithTarget:self action:@selector(handleLongEvent:)];
    [self addGestureRecognizer:longPressRecognizer];
}

//=== Drag and drop functionality ===//
#pragma mark - Drag and drop functionality

- (void)handleLongEvent:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint const touchLocation = [recognizer locationInView:self];
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            // Abort dragging if no cell at touch point
            if ([self indexPathForRowAtPoint:touchLocation].row == NSNotFound) {
                MKLogDebug(@"No cell at touch location. Aborting drag...");
                [recognizer setEnabled:NO]; // Reset recognizer to cancel drag gesture
                [recognizer setEnabled:YES];
                break;
            }

            [self cellDraggingDidBegin:touchLocation];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self cellDraggingDidContinue:touchLocation];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self cellDraggingDidEnd];

            break;
        }
        default:
            break;
    }
}

- (void)cellDraggingDidBegin:(CGPoint)touchLocation
{
    MKLogDebug(@"Dragging did begin.")
    NSIndexPath *const indexPathOfDraggedCell = [self indexPathForRowAtPoint:touchLocation];
    self.draggedCell = [self cellForRowAtIndexPath:indexPathOfDraggedCell];

    // Take cell snapshot and add as subview
    self.draggedCell.selected = NO; // It's important to deselect the cell *before* taking the snapshot
    UIImage *const cellSnapshotImage = [self.draggedCell takeSnapshot];
    self.cellSnapshotView = [[UIImageView alloc] initWithImage:cellSnapshotImage];

    CGRect snapshotFrame = [self rectForRowAtIndexPath:indexPathOfDraggedCell];
    snapshotFrame.size = self.draggedCell.frame.size;
    snapshotFrame.origin.y -= 5; // Offset the snapshot a bit making it look like it has been lifted up
    [self.cellSnapshotView setFrame:snapshotFrame];
    [self.cellSnapshotView setAlpha:0.95f];
    [self addSubview:self.cellSnapshotView];

    // make the original cell invisible to make it look like the snapshot is the real one
    self.draggedCell.hidden = YES;

    self.previousTouchLocation = touchLocation;

}

- (void)cellDraggingDidContinue:(CGPoint)touchLocation
{
    // Update position of snapshot
    CGRect snapshotFrame = [self.cellSnapshotView frame];
    snapshotFrame.origin.y      = snapshotFrame.origin.y + (touchLocation.y - self.previousTouchLocation.y);
    self.cellSnapshotView.frame = snapshotFrame;

    NSIndexPath *const indexPathAtTouchLocation = [self indexPathForRowAtPoint:touchLocation];
    NSIndexPath *const indexPathOfCell          = [self indexPathForCell:self.draggedCell];

    if (indexPathAtTouchLocation && (indexPathAtTouchLocation.row != indexPathOfCell.row) &&
        (indexPathAtTouchLocation.row != NSNotFound) && (indexPathAtTouchLocation.section == indexPathOfCell.section)) {
        [self beginUpdates];
        [self moveRowAtIndexPath:indexPathOfCell toIndexPath:indexPathAtTouchLocation];
        // I would expect this to be called by the call above, but that doesn't seem to be true. so we have to do it manually
        [self.dataSource tableView:self moveRowAtIndexPath:indexPathOfCell toIndexPath:indexPathAtTouchLocation];
        [self endUpdates];
    }

    self.previousTouchLocation = touchLocation;
}

- (void)cellDraggingDidEnd
{
    NSIndexPath *indexPathOfDraggedCell = [self indexPathForCell:self.draggedCell];
    CGRect      newSnapshotFrame        = [self rectForRowAtIndexPath:indexPathOfDraggedCell];

    [UIView animateWithDuration:0.2 animations:^{
        [[self cellSnapshotView] setFrame:newSnapshotFrame];
        [[self cellSnapshotView] setAlpha:1.0];
    } completion:^(BOOL completion) {
        if (completion) {
            [[self cellSnapshotView] removeFromSuperview];
            self.draggedCell.hidden = NO;
            [self reloadRowsAtIndexPaths:self.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

@end
