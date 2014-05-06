//
//  MKRemoteSettings.m
//  MKCommons
//
//  Created by Michael Kuck on 11/10/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKJsonObject.h"

#import "MKLog.h"

typedef void (^MKRemoteSettingsSuccessBlock)(NSDictionary *dictionary);
typedef void (^MKRemoteSettingsFailureBlock)(NSError *error);

@interface MKJsonObject ()

@property (nonatomic, copy) MKRemoteSettingsSuccessBlock successBlock;
@property (nonatomic, copy) MKRemoteSettingsFailureBlock failureBlock;
@property (nonatomic, strong) NSDictionary *jsonDictionary;

@end

@implementation MKJsonObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _successBlock = nil;
        _failureBlock = nil;
        _jsonDictionary = nil;
    }
    return self;
}

- (NSDictionary *)dictionary
{
    return self.jsonDictionary;
}

- (void)fetchFromURL:(NSURL *)url
             success:(MKRemoteSettingsSuccessBlock)successBlock
             failure:(MKRemoteSettingsFailureBlock)failureBlock
{
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    MKLogInfo(@"Fetching json data from server: %@", [url description]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSData *const jsonData = [NSData dataWithContentsOfURL:url];
        if (!jsonData) {
            MKLogError(@"Couldn't connect to remote URL.");
            return;
        }
        
        NSError *error;
        self.jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:kNilOptions
                                                               error:&error];
        if (error) {
            MKLogError(@"Error while parsing remote json obect: %@", [error localizedDescription]);
        }
        MKLogVerbose(@"JSON download finished.");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                if (self.successBlock != nil) {
                    self.successBlock(self.jsonDictionary);
                    self.successBlock = nil;
                }
            } else {
                if (self.failureBlock != nil) {
                    self.failureBlock(error);
                    self.failureBlock = nil;
                }
            }
        });
    });
}

@end
