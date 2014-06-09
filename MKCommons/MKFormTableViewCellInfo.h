//
//  MKFormTableViewCellInfo.h
//  MKCommons
//
//  Created by Michael Kuck on 5/12/14.
//  Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKFormTableViewCellSeparator.h"

//============================================================
//== Public Interface
//============================================================
@interface MKFormTableViewCellInfo : MKFormTableViewCellSeparator

@property (strong, nonatomic, readonly) UILabel *label;

- (instancetype)initWithText:(NSString *)text;

@end
