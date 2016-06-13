//
//  MFUserHandler.h
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFUserHandler : NSObject

@property(nonatomic,assign) LogInType loginType;
@property(nonatomic,strong) NSString* token;
@property(nonatomic,strong) NSNumber* userId;
@property(nonatomic,strong) NSString* userName;
@property(nonatomic,strong,readonly) NSString* email;

/**
 *  处理登录成功信息
 *  @param info info
 *  @return bool
 */
- (BOOL)handleSignInFinishedUserInfo:(NSDictionary*)info;
/**
 *  更新用户信息
 *
 *  @param info info
 */
- (void)updateUserInfo:(NSDictionary*)info;
/**
 *  是否是游客登录
 *
 *  @return bool
 */
- (BOOL)isGuestSignIn;
/**
 *  是否正常登录
 *
 *  @return bool
 */
- (BOOL)isAuthVaild;
/**
 *  重置信息
 */
- (void)reset;
/**
 * 检查是否登录，回弹出登录界面
 *
 *  @param completion
 */
+ (void)checkAuthVaild:(void(^)(BOOL isLogin))completion;


@end
