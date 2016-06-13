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

    
    
}


- (BOOL)isGuestSignIn
{
 
    return YES;
}

- (void)isAuthVaild
{


}

- (NSNumber*)userId
{
    return @1;
}


@end
