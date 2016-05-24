//
//  PPRequest+Transformer.m
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPRequest+Extension.h"
#import "PPAPIStatusGenerator.h"
#import "MFNetworkingHelper.h"
#import "Macros.h"

//response key
static NSString *const kResponseKeyContent         = @"content";

static void *PPNetworkingApiStatus;

@implementation MFRequest (MFRequest_Extension)
@dynamic status;

#pragma mark Property

- (id)content{
    if (isValidDictionary(self.responseObject)) {
        return self.responseObject[kResponseKeyContent];
    }
    return nil;
}

- (PPApiStatus *)status{
    id _status = objc_getAssociatedObject(self,&PPNetworkingApiStatus);
    if (!_status) {
        _status = [PPAPIStatusGenerator generateApiStatusWithRequest:self];
        self.status = _status;
    }
    return _status;
}

- (void)setStatus:(PPApiStatus *)status{
    objc_setAssociatedObject(self,&PPNetworkingApiStatus,status, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark PPRequestInjector

- (void)initInjector:(MFRequest *)request
{
    //加载各种reformer和interceptor
    MFNetworkingHelper *manager = [MFNetworkingHelper sharedInstance];
    request.requestReformer = manager;
    request.responseReformer = manager;
    request.interceptor = manager;
}

@end
