//
//  MKRemoteSettings.h
//  MKCommons
//
//  Created by Michael Kuck on 11/10/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKJsonObject : NSObject

@property (strong, nonatomic, readonly) id response;

- (instancetype)initWithUrl:(NSURL *)url;
- (void)fetchContentSuccess:(void (^)(id response))successBlock failure:(void (^)(NSError *error))failureBlock;

@end
