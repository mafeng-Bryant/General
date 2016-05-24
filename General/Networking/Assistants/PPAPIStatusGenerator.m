//
//  PPAPIStatusGenerator.m
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPAPIStatusGenerator.h"

//response key
static NSString *const kResponseKeyStatus            = @"status";
static NSString *const kResponseKeyMsg               = @"msg";

@implementation PPAPIStatusGenerator

+ (PPApiStatus *)generateApiStatusWithRequest:(MFRequest*)request
{
    NSDictionary *responseResult = [request responseObject];
    if (isValidDictionary(responseResult)) {
        id status = responseResult[kResponseKeyStatus];
        id msg = responseResult[kResponseKeyMsg];
        if ([PPAPIStatusGenerator statusIsValid:status] && isValidString(msg)) {
            NSString *code = [NSString stringWithFormat:@"%@",status];
            NSString *description = [NSString stringWithFormat:@"%@",msg];
            PPApiStatus *apistatus = [PPAPIStatusGenerator createStatus:code description:description domain:[request.absoluteString stringByDeletingLastPathComponent]];
            return apistatus;
        }
    }
    return nil;
}

#pragma mark Private methord

+ (BOOL)statusIsValid:(id)status
{
    return (isValidString(status) || isValidNumber(status));
}

+ (PPApiStatus *)createStatus:(NSString *)code
                  description:(NSString *)description
                       domain:(NSString *)domain
{
    if (!code)return nil;
    if (!isValidString(description)) {
        description = @"";
    }
    if (!isValidString(domain)) {
        domain = @"www.patpat.com";
    }
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:description};
    PPApiStatus *status = [PPApiStatus statusWithDomain:domain code:code userInfo:userInfo];
    return status;
}

@end
