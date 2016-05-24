//
//  MFNetworkingConfig.h
//  General
//
//  Created by patpat on 16/5/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    MFRequestPrintLogTypeNone, //no request log will be printed
    MFRequestPrintLogTypeJSON, //request log will be printed with json format
    MFRequestPrintLogTypeNSObject //request log will be printed with NSObject format,e.g:NSArray,NSDictionary
}MFRequestPrintLogType;


@interface MFNetworkingConfig : NSObject
@property (readonly) NSString* host;
@property (readonly) AFHTTPRequestSerializer  *requestSerializer ; //request serializer
@property (readonly) AFHTTPResponseSerializer *responseSerializer ; //response serializer
@property (nonatomic,assign) NSInteger timeoutInterval;
@property (nonatomic,assign) MFRequestPrintLogType printLogType;

/**
 *  初始化示例
 *
 *  @return MFNetworkingConfig
 */
+ (MFNetworkingConfig*)sharedInstance;

//设置host
+ (void)initWithHost:(NSString*)host;

/**
 *  初始化网络模块
 *
 *  @param host               host
 *  @param requestSerializer  请求的requestSerializer
 *  @param responseSerializer 处理请求返回内容的responseSerializer
 */
+ (void)initWithHost:(NSString *)host
   requestSerializer:(AFHTTPRequestSerializer*)requestSerializer
  responseSerializer:(AFHTTPResponseSerializer*)responseSerializer;



@end
