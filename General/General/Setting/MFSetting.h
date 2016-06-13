//
//  MFSetting.h
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFUserHandler.h"

@interface MFSetting : NSObject
@property(nonatomic,strong) MFUserHandler* userHandle; //用户类
/**
 *  单列对象
*/
+ (MFSetting*)sharedMFSetting;
/**
 *  重置
 */
- (void)reset;
/**
 *  是否是游客登录
 *
 *  @return Bool
 */
+ (BOOL)isGuestSignIn;

/**
 *  是否正常登录
 */
+ (BOOL)isAuthVaild;

/**
 *  用户id
 *
 *  @return NSNumber
 */
+ (NSNumber*)userId;

@end
