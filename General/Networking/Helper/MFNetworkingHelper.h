//
//  PPNetworkingManager.h
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPRequest+Extension.h"
#import "MFHostHelper.h"

@interface MFNetworkingHelper : NSObject<PPRequestReformer,PPResponseReformer,PPResponseInterceptor>
+ (MFNetworkingHelper *)sharedInstance;
+ (void)init;
@end
