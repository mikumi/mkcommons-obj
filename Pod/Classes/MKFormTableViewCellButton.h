//
//  MKFormTableViewCellButton.h
//  MKCommons
//
//  Created by Michael Kuck on 5/13/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKFormTableViewCellSeparator.h"

//============================================================
//== Public Interface
//============================================================
@interface MKFormTableViewCellButton : MKFormTableViewCellSeparator

@property (strong, nonatomic, readonly) UIButton *button;

- (instancetype)initWithTitle:(NSString *)title;

@end
