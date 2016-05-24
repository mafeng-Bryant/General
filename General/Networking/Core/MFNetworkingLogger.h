//
//  PPNetworkingLogger.h
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPRequest.h"

@interface MFNetworkingLogger : NSObject

+ (void)printWithRequest:(NSString *)className
                 methord:(NSString *)methord
                     url:(NSString *)url
                 headers:(NSDictionary *)headers
                  params:(id)params;

+ (void)printResponse:(PPRequest *)request
                error:(NSError *)error;

@end
