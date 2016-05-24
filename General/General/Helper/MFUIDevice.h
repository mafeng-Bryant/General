//
//  MFUIDevice.h
//  General
//
//  Created by patpat on 16/5/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFUIDevice : NSObject

/**
 *  设备信息
 *
 *  @return dictionary
 */
+ (NSDictionary*)deviceInfo;

/**
 *  设备的唯一标识符
 *
 *  @return string
 */
+ (NSString*)deviceUUID;



@end
