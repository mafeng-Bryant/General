//
//  MFUserHandler.m
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFUserHandler.h"
#import "PPStoreHelper.h"

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
    
    
    

}


- (BOOL)handleSignInFinishedUserInfo:(NSDictionary*)info
{

    
    
    return NO;
}


- (void)updateUserInfo:(NSDictionary*)info
{


}


- (BOOL)isGuestSignIn
{

    return YES;
}

- (BOOL)isAuthVaild
{

    return YES;
}

- (void)reset
{


}

+ (void)checkAuthVaild:(void(^)(BOOL isLogin))completion
{

 
    

}

@end
