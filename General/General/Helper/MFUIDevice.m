//
//  MFUIDevice.m
//  General
//
//  Created by patpat on 16/5/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFUIDevice.h"
#import "VDevice.h"
#import "PPStoreHelper.h"
#import "NSObject+Extensions.h"
#import "VMacros.h"
#import "VExtensions.h"


static NSString * const kDeviceUUID   = @"kechain.deviceuuid";

@implementation MFUIDevice

+ (NSDictionary*)deviceInfo
{
    NSDictionary *otherInfo = @{@"mode":FormatString([VDevice deviceModel],@"")};
    return  @{@"deviceinfo":[otherInfo toJsonString],@"device_id":[self deviceUUID],@"operation_system":FormatString([VDevice systemName],@""),@"device_type":FormatString([VDevice deviceType], @""),@"os_version":FormatString([VDevice systemVersion], @"")};
}

+ (NSString*)deviceUUID
{
    NSString *uuid = [PPStoreHelper getSystemValueForKey:kDeviceUUID];
    if (!isValidString(uuid)) {
        uuid = [NSString createCUID];
        [PPStoreHelper systemStoreValue:uuid forKey:kDeviceUUID];
    }
    return uuid;
}

@end
