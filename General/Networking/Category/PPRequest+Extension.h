//
//  PPRequest+Transformer.h
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPRequest.h"

@interface PPRequest (PPRequest_Extension)<PPRequestInjector>

@property (nonatomic, strong, readonly) PPApiStatus *status; //内容业务逻辑状态
@property (nonatomic, strong, readonly) id content; //kResponseKeyContent 内容


@end
