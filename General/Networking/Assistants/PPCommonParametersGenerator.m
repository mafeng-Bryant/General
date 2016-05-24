//
//  PPCommonParametersGenerator.m
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPCommonParametersGenerator.h"

@implementation PPCommonParametersGenerator

+ (NSDictionary *)commonParameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"timestamp"] = @([[NSDate date]timeIntervalSince1970]);
//    if (isValidString([PPSetting sharedPPSetting].userHandler.token)) {
//        parameters[@"user_token"]=[PPSetting sharedPPSetting].userHandler.token;
//    }
    return parameters;
}

@end
