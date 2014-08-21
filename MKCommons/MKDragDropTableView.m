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
@property (nonatomic, strong) UIImageView   *cellSnapshot;
@property (nonatomic, assign) CGPoint       previousTouchLocation;

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
    MKLogVerbose(@"Initializing instance...");
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
    MKLogVerbose(@"Dragging did begin.")
    NSIndexPath *const indexPathOfDraggedCell = [self indexPathForRowAtPoint:touchLocation];
    self.draggedCell = [self cellForRowAtIndexPath:indexPathOfDraggedCell];

    self.draggedCell.selected = NO;

    // take the snapshot
    UIImage *cellSnapshot = [self.draggedCell takeSnapshot];

    // add snapshot image as subview
    self.cellSnapshot = [[UIImageView alloc] initWithImage:cellSnapshot];
    CGRect snapshotFrame = [self rectForRowAtIndexPath:indexPathOfDraggedCell];
    snapshotFrame.size = self.draggedCell.frame.size;
    snapshotFrame.origin.y -= 5; // Offset the snapshot a bit making it look like it has been lifted up
    [self.cellSnapshot setFrame:snapshotFrame];
    [self.cellSnapshot setAlpha:0.95f];
    [self addSubview:self.cellSnapshot];
    // make the original cell invisible to make it look like the snapshot is the real one
    self.draggedCell.hidden = YES;

    self.previousTouchLocation = touchLocation;

}

- (void)cellDraggingDidContinue:(CGPoint)touchLocation
{
    // Update position of snapshot
    CGRect snapshotFrame = [self.cellSnapshot frame];
//    snapshotFrame.origin.y  = touchLocation.y + self.currentCellSnapshotOffsetY;
    snapshotFrame.origin.y  = snapshotFrame.origin.y + (touchLocation.y - self.previousTouchLocation.y);
    self.cellSnapshot.frame = snapshotFrame;

    // Update table
    NSIndexPath *indexPathNew = [self indexPathForRowAtPoint:touchLocation];
    NSIndexPath *indexPathOld = [self indexPathForCell:self.draggedCell];

    if (indexPathNew && (indexPathNew.row != indexPathOld.row) && (indexPathNew.row != NSNotFound) &&
        (indexPathNew.section == indexPathOld.section)) {
        // TODO: delegate didMove to datasource
        [self beginUpdates];
        [self moveRowAtIndexPath:indexPathOld toIndexPath:indexPathNew];
        // I would expect this to be called by the call above, but it doesn't. so we have to do it manually
        [self.dataSource tableView:self moveRowAtIndexPath:indexPathOld toIndexPath:indexPathNew];
        [self endUpdates];
    }

    self.previousTouchLocation = touchLocation;
}

- (void)cellDraggingDidEnd
{
    NSIndexPath *indexPathOfDraggedCell = [self indexPathForCell:self.draggedCell];
    CGRect      newSnapshotFrame        = [self rectForRowAtIndexPath:indexPathOfDraggedCell];

    [UIView animateWithDuration:0.2 animations:^{
        [[self cellSnapshot] setFrame:newSnapshotFrame];
        [[self cellSnapshot] setAlpha:1.0];
    } completion:^(BOOL completion) {
        if (completion) {
            [[self cellSnapshot] removeFromSuperview];
            [self reloadData];
            self.draggedCell.hidden = NO;
        }
    }];
}

@end
