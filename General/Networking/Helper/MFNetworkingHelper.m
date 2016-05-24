//
//  PPNetworkingManager.m
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "MFNetworkingHelper.h"
#import "MFNetworking.h"
#import "PPCommonHeadersGenerator.h"
#import "PPCommonParametersGenerator.h"
#import "PPSignatureGenerator.h"
#import "AppDelegate.h"
#import "Macros.h"

@interface MFNetworkingHelper()
{
    BOOL _isShowingLoginAlert;
}
@end

@implementation MFNetworkingHelper

+ (MFNetworkingHelper *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)init{
    [MFNetworkingHelper sharedInstance];
}

- (id)init {
    self = [super init];
    if (self) {
        [MFNetworkingConfig initWithHost:[MFHostHelper getHost]];
        [MFNetworkingConfig sharedInstance].printLogType = MFRequestPrintLogTypeNSObject;
    }
    return self;
}

#pragma mark PPRequestReformer

- (void)requestReformerWithHeaders:(id)headers
                        parameters:(id)parameters
                          finished:(void (^)(id newHeaders, id newParameters))result
{
    //reformer parameters
    NSDictionary *commonParameters = [PPCommonParametersGenerator commonParameters];
    NSDictionary *requestParameters = parameters;
    NSMutableDictionary *allParameters = [NSMutableDictionary dictionaryWithDictionary:commonParameters];
    if (isValidDictionary(requestParameters)) {
        [allParameters addEntriesFromDictionary:requestParameters];
    }
    NSDictionary *finalParameters = @{@"p":[allParameters toJsonString]};
    
    //reformer headers
    NSDictionary *commonHeaders = [PPCommonHeadersGenerator commonHeaders];
    NSMutableDictionary *finalHeaders = [NSMutableDictionary dictionaryWithDictionary:commonHeaders];
    NSString *sign =  [PPSignatureGenerator generateSignatureWithParameters:allParameters];
    finalHeaders[@"sign"] = sign;
    result(finalHeaders,finalParameters);
}

#pragma mark PPResponseReformer

- (void)responseReormer:(PPRequest *)request
{
    if (!request.error) {
        [request status];  //请求成功了生成业务相关的status
        if (request.status && !request.status.normal) { //在这里将NSError和PPStatus合并为一个error
            NSMutableDictionary *descriptionDict = [NSMutableDictionary dictionary];
            descriptionDict[NSLocalizedErrorSummaryKey] = PPString(SHOPPINGCART_OOPS);
            descriptionDict[NSLocalizedDescriptionKey] = request.status.localizedDescription;
            request.error = [NSError errorWithDomain:request.status.domain code:[request.status.code integerValue] userInfo:descriptionDict];
        }
    }else{
        //重新设置请求失败的error信息
        NSMutableDictionary *descriptionDict = [NSMutableDictionary dictionary];
        if (![PPNetworking isConnected]) { //lost network
            descriptionDict[NSLocalizedErrorSummaryKey]=PPString(NETWORKERROR);
            descriptionDict[NSLocalizedDescriptionKey] = PPString(DISCONNECTEDINTERNET);
        }else{
            descriptionDict[NSLocalizedErrorSummaryKey]=PPString(REQUESTERROR);
            descriptionDict[NSLocalizedDescriptionKey] = request.error.localizedDescription;
        }
        request.error = [NSError errorWithDomain:request.error.domain code:request.error.code userInfo:descriptionDict];
    }
}

#pragma mark PPNetworkingInterceptor

- (void)interceptResponse:(MFRequest *)request
{
    PPApiStatus *apistatus = request.status;
    if (apistatus&&[apistatus.code isEqualToString:@"1001"]) { //token过期了
        apistatus.localizedDescription = FormatString(apistatus.localizedDescription,PPString(AUTHENTICATIONLOGINAGAIN));
        [self verifyAccount:apistatus];
        apistatus.localizedDescription = @"";
    }
}

#pragma mark 拦截后处理业务逻辑

//检查帐号token是否有效，如果过期就跳到登录界面
- (void)verifyAccount:(PPApiStatus *)status
{
    if (_isShowingLoginAlert || ![PPSetting isAuthValid]) {
        return;
    }
    _isShowingLoginAlert = YES;
    [UIAlertView showAlertViewWithTitle:nil  message:status.localizedDescription  cancelButtonTitle:nil
                      otherButtonTitles:@[PPString(OK_STRING)]
                              onDismiss:^(NSInteger buttonIndex) {
                                  _isShowingLoginAlert = NO;
                                  [[AppDelegate appDelegate]signOut];
                              } onCancel:nil];
}

@end
