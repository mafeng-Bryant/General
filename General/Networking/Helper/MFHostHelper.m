//
//  PPUrlManager.m
//  PatPat
//
//  Created by patpat on 15/3/10.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "MFHostHelper.h"
#import "PPStoreHelper.h"
#import "AppDelegate.h"
#import "MFNetworkingConfig.h"
#import "Macros.h"

@implementation MFHostObject
@synthesize title;
@synthesize host;
@end

@implementation MFHostHelper

+ (MFHostHelper *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSArray *)hosts
{
    NSMutableArray *hosts = [NSMutableArray array];
    
    //AliYun测试服务器1
    MFHostObject *object = [[MFHostObject alloc]init];
    object.host = @"http://120.24.223.178:2999/V1.3";
    object.title = @"Aliyun Test Server1";
    object.type = MFHostTypeTest;
    [hosts addObject:object];
    
    object = [[MFHostObject alloc]init];
    object.host = @"http://120.24.223.178:8081/V1.3";
    object.title = @"Aliyun Test Server2";
    object.type = MFHostTypeTest;
    [hosts addObject:object];

    //正式服务器
    object = [[MFHostObject alloc]init];
    object.host = kStatgeHost;
    object.title = @"Amazon Product Server";
    object.type = MFHostTypeProduct;
    [hosts addObject:object];
    
    return hosts;
}

+ (NSString *)currentServerHost
{
    return [MFNetworkingConfig sharedInstance].host;
}

+ (void)setHost:(NSString *)host
{
    [PPStoreHelper storeValue:host forKey:[self hostKey]];
}

+ (NSString *)getHost
{
    NSString *_serverHost = nil;
#if defined(DEBUG) || defined(ADHOC)
    _serverHost = [PPStoreHelper getValueForKey:[self hostKey]];
#endif
    if (!isValidString(_serverHost)) {
        _serverHost = [self hostWithType:MFHostTypeProduct];
    }
    return _serverHost;
}

#pragma mark Private methord

+ (NSString *)hostKey
{
    return @"server.host";
}

+ (NSString *)hostWithType:(MFHostType)type
{
    for (MFHostObject *object in [self hosts]) {
        if (object.type == type) {
            return object.host;
        }
    }
    return nil;
}

#pragma mark Change url

- (void)changeUrl
{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"change url"
//                                                            delegate:self
//                                                   cancelButtonTitle:nil
//                                              destructiveButtonTitle:nil
//                                                   otherButtonTitles:nil];
//    NSArray *hosts = [MFHostHelper hosts];
//    for (MFHostObject *hostObject in hosts) {
//        NSString *currentHost = [MFHostHelper currentServerHost];
//        if ([currentHost isEqualToString:hostObject.host]) {
//            [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"[√]%@(%@)",hostObject.title,hostObject.host]];
//        }else{
//            [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@(%@)",hostObject.title,hostObject.host]];
//        }
//    }
//    [actionSheet addButtonWithTitle:@""];
//  //  actionSheet.delegate = self;
   // [actionSheet showInView:[AppDelegate appDelegate].rootViewController.view];
}

#pragma mark UIActionSheetDelegate methord

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray *hosts = [MFHostHelper hosts];
    if (buttonIndex>hosts.count-1) {
        return;
    }
    MFHostObject *hostObject = hosts[buttonIndex];
    [MFHostHelper setHost:hostObject.host];
  //  [[PPSetting sharedPPSetting]reset]; //需要用户重新登陆
    [self exitApplication];
}

- (void)exitApplication {
//    UIWindow *window = [AppDelegate appDelegate].window;
//    [UIView animateWithDuration:1.0f animations:^{
//        window.alpha = 0;
//        window.size = CGSizeZero;
//        window.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
//    } completion:^(BOOL finished) {
//        exit(0);
//    }];
}

@end
