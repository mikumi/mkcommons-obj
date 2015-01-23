//
//  MKRemoteSettings.m
//  MKCommons
//
//  Created by Michael Kuck on 11/10/13.
//  Copyright (c) 2013 Michael Kuck. All rights reserved.
//

#import "MKJsonObject.h"

#import "MKLog.h"

typedef void (^MKRemoteSettingsSuccessBlock)(id response);
typedef void (^MKRemoteSettingsFailureBlock)(NSError *error);

//============================================================
//== Private Interface
//============================================================
@interface MKJsonObject ()

@property (strong, nonatomic) NSURL *url;
@property (copy, nonatomic) MKRemoteSettingsSuccessBlock successBlock;
@property (copy, nonatomic) MKRemoteSettingsFailureBlock failureBlock;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKJsonObject

/*
 * (Inherited Comment)
 */
- (instancetype)init
{
    MKLogError(@"Not initialized, use initWithUrl: instead");
    return [self initWithUrl:nil];
}

/**
 * // DOCU: this method comment needs be updated.
 */
- (instancetype)initWithUrl:(NSURL *)url
{
    self = [super init];
    if (self) {
        _url = url;
        _successBlock = nil;
        _failureBlock = nil;
        _response = nil;
    }
    return self;
}

- (void)fetchContentSuccess:(void (^)(id response))successBlock failure:(void (^)(NSError *error))failureBlock
{
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    MKLogInfo(@"Fetching json data from server: %@", [self.url description]);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *const jsonData = [NSData dataWithContentsOfURL:self.url];
        if (!jsonData) {
            MKLogError(@"Couldn't connect to remote URL.");
            return;
        }

        NSError *error;
        _response = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingOptions)kNilOptions
                                                      error:&error];
        if (error) {
            MKLogError(@"Error while parsing remote json obect: %@", [error localizedDescription]);
        }
        MKLogDebug(@"JSON download finished.");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                if (self.successBlock != nil) {
                    self.successBlock(self.response);
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

/**
 * // DOCU: this method comment needs be updated.
 */
- (void)setresponse:(id)response
{
    _response = response;
}

@end
