//
//  MFSetting.m
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFSetting.h"

@implementation MFSetting

static MFSetting* setting = nil;

+ (MFSetting*)sharedMFSetting
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        setting = [[self alloc]init];
    });
    return setting;
}

- (void)reset
{
    [self.userHandle reset];
}

+ (BOOL)isGuestSignIn
{
    return [[MFSetting sharedMFSetting].userHandle isGuestSignIn];
}

+ (BOOL)isAuthVaild
{
    return [[MFSetting sharedMFSetting].userHandle isAuthVaild];
}

+ (NSNumber*)userId
{
   return [MFSetting sharedMFSetting].userHandle.userId;
}

#pragma mark Setter and Getter

- (MFUserHandler *)userHandle
{
    if (!_userHandle) {
        _userHandle = [[MFUserHandler alloc]init];
    }
    return _userHandle;
}

@end
