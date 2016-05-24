//
//  MFNetworkingConfig.m
//  General
//
//  Created by patpat on 16/5/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFNetworkingConfig.h"

@interface MFNetworkingConfig()
@property (nonatomic,strong) NSString* host;
@property (nonatomic,strong) AFHTTPRequestSerializer  *requestSerializer;
@property (nonatomic,strong) AFHTTPResponseSerializer *responseSerializer;

@end

@implementation MFNetworkingConfig

-(instancetype)init
{
    self = [super init];
    if (self) {
        _host = nil;
        _timeoutInterval = 30; //default 30s
        _printLogType = MFRequestPrintLogTypeNSObject; //default string
        _requestSerializer = [AFHTTPRequestSerializer serializer];
        _responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

+ (MFNetworkingConfig*)sharedInstance
{
    static id shareInstance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

+ (void)initWithHost:(NSString*)host
{
    [self initWithHost:host requestSerializer:nil responseSerializer:nil];
}

+ (void)initWithHost:(NSString *)host
   requestSerializer:(AFHTTPRequestSerializer*)requestSerializer
  responseSerializer:(AFHTTPResponseSerializer*)responseSerializer
{
    NSAssert(host, @"host 不能为空!");
    [[MFNetworkingConfig sharedInstance] setHost:host];
     if (requestSerializer) {
        [[MFNetworkingConfig sharedInstance] setRequestSerializer:requestSerializer];
     }
    if (responseSerializer) {
        [[MFNetworkingConfig sharedInstance] setResponseSerializer:responseSerializer];
    }
}



@end
