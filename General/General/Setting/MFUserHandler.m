//
//  MFUserHandler.m
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFUserHandler.h"
#import "PPStoreHelper.h"
#import "MFUserModel.h"
#import "MFSetting.h"

static NSString* const kUserLoginType        = @"general.kechain.loginType";
static NSString* const kUserId               = @"general.kechain.userId";
static NSString* const kUserToken            = @"general.kechain.usertoken";

@interface MFUserHandler()

@end

@implementation MFUserHandler

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self configure];
    }
    return self;
 }

- (void)configure
{
    NSNumber* loginType = [PPStoreHelper getValueForKey:kUserLoginType];
    self.loginType = loginType?(LogInType)[loginType integerValue]:LogInTypeUnknown;
    self.userId = FormatNumber([PPStoreHelper getValueForKey:kUserId], nil);
    self.token = FormatString([PPStoreHelper getValueForKey:kUserToken], @"");
    MFUserModel* userModel = [MFUserModel readByUserId:self.userId];
    if (userModel && self.token && self.userId) {
        self.userName = userModel.userName;
    }else {
        [self initUserInfo];//没有登录过
    }
}

- (void)initUserInfo
{
   self.token = @"";
   self.userId = nil;
   self.loginType = LogInTypeUnknown;
   self.userName = @"";
}

- (BOOL)handleSignInFinishedUserInfo:(NSDictionary*)info
{
    if (isValidDictionary(info)) {
        MFUserModel* user = [MTLJSONAdapter modelOfClass:[MFUserModel class] fromJSONDictionary:info error:nil];
        if (user && user.userId && [user save]) {
            [PPStoreHelper storeValue:@(user.loginType) forKey:kUserLoginType];
            [PPStoreHelper storeValue:user.userId forKey:kUserId];
            [PPStoreHelper storeValue:user.userToken forKey:kUserToken];
            [self configure];
            return YES;
       }
    }
    return NO;
}


- (void)updateUserInfo:(NSDictionary*)info
{
    if (isValidDictionary(info)) {
        MFUserModel* user = [MTLJSONAdapter modelOfClass:[MFUserModel class] fromJSONDictionary:info error:nil];
        if (user && user.userId && [user save]) {
            self.userName = user.userName;
        }
    }
}

- (BOOL)isGuestSignIn
{
    if (self.loginType ==LogInTypeGuest) {
        return YES;
    }
    return NO;
}

- (BOOL)isAuthVaild
{
    if (![self isGuestSignIn] && isValidString(self.token) && self.userId && [MFUserModel isCachedByUserId:self.userId]) {
        return YES;
    }
    return NO;
}

- (void)reset
{
    [MFUserModel deleteUserByUserId:self.userId];
    [PPStoreHelper storeValue:nil forKey:kUserLoginType];
    [PPStoreHelper storeValue:nil forKey:kUserId];
    [PPStoreHelper storeValue:nil forKey:kUserToken];
    [self initUserInfo];
}

+ (void)checkAuthVaild:(void(^)(BOOL isLogin))completion
{
    if (![MFSetting isAuthVaild]) {
    
    //弹出界面
    }else {
        if (completion) {
            completion(YES);
        }
   }

}

@end
