//
//  PPMapManager.m
//  General
//
//  Created by patpat on 16/6/8.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PPMapManager.h"

@implementation PPMapManager

static PPMapManager* _instance = nil;

+ (PPMapManager*)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance ;
}

- (void)starBaiduMap
{
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:KBaiduApiKey generalDelegate:nil];
    if (!ret) {
        NSLog(@"start failed");
    }
}

@end
