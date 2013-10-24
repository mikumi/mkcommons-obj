//
//  MKRemoteSettings.h
//  MKCommons
//
//  Created by Michael Kuck on 11/10/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKJsonObject : NSObject

- (NSDictionary *)dictionary;
- (void)fetchFromURL:(NSURL *)url
           success:(void(^)(NSDictionary *dictionary))successBlock
           failure:(void(^)(NSError *error))failureBlock;

@end
