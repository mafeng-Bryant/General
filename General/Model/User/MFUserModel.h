//
//  MFUserModel.h
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFBaseModel.h"

@interface MFUserModel :MFBaseModel
@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSNumber *loginId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *lastLogin;
@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, copy) NSDate *registrationDate; //注册时间
@property (nonatomic, assign, readonly) LogInType loginType;

/**
 *  删除当前用户信息
 */
- (void)deleteCurrentUser;

/**
 *  通过用户ID读取用户信息
 *
 *  @param userId
 *
 *  @return self
 */
+ (MFUserModel*)readByUserId:(NSNumber*)userId;


/**
 *  获取当前用户
 *
 *  @return self
 */
+ (MFUserModel*)currentUser;


/**
 *  通过用户ID删除用户
 *
 *  @param userId
 */
+ (void)deleteUserByUserId:(NSNumber*)userId;

/**
 *  检测是否缓存用户信息
 *
 *  @param userId
 *
 *  @return bool
 */
+ (BOOL)isCachedByUserId:(NSNumber*)userId;







@end
