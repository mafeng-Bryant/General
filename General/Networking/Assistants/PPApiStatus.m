//
//  PPApiStatus.m
//  PatPat
//
//  Created by Yuan on 15/1/8.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPApiStatus.h"
#import "Macros.h"

@implementation NSError(PP_Error)

- (NSString *)descriptionSummary
{
    if (isValidDictionary(self.userInfo)) {
        return FormatString(self.userInfo[NSLocalizedErrorSummaryKey],@"");
    }
    return @"";
}

@end

@implementation PPApiStatus

- (id)initWithDomain:(NSString *)d
                code:(NSString *)c
            userInfo:(NSDictionary *)dict
{
    self =[super init];
    if (!self){
        return nil;
    }
    _domain = d;
    _code =c;
    _userInfo = dict;
    _localizedDescription = self.userInfo[NSLocalizedDescriptionKey];
    return self;
}

+ (id)statusWithDomain:(NSString *)_domain
                 code:(NSString *)_code
             userInfo:(NSDictionary *)dict{
    PPApiStatus *status =  [[PPApiStatus alloc]initWithDomain:_domain code:_code userInfo:dict];
    return status;
}

- (BOOL)normal{
    if (isValidString(self.code) && [self.code integerValue] == kPPApiStatusNormal) {
        return YES;
    }
    return NO;
}

@end
