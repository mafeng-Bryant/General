//
//  PPCommonHeadersGenerator.m
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPCommonHeadersGenerator.h"
#import "VDevice.h"

@implementation PPCommonHeadersGenerator

+ (NSDictionary *)commonHeaders;
{
    return @{@"appversion":kAppVersion,
             @"buildversion":kAppBuildVersion,
             @"platform":@"ios",
             @"screensize":FormatString([VDevice screenSize],@""),
             @"country":FormatString([VDevice country],@""),
             @"language":FormatString([VDevice language],@""),
             @"timezonename":FormatString([VDevice timeZone],@""),
             @"timezone":FormatString([NSTimeZone systemTimeZone].abbreviation,@""),
             @"deviceid":FormatString([UIDevice deviceUUID],@""),
             @"currency":FormatString([[VDevice currency] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"")};
}

@end
