//
//  PPAPIStatusGenerator.h
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPApiStatus.h"
#import "MFNetworkingHeader.h"

@interface PPAPIStatusGenerator : NSObject

+ (PPApiStatus *)generateApiStatusWithRequest:(PPRequest *)request;

@end
