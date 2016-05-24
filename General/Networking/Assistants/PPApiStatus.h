//
//  PPApiStatus.h
//  PatPat
//
//  Created by Yuan on 15/1/8.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const NSLocalizedErrorSummaryKey = @"NSLocalizedErrorSummaryKey";  // NSString

@interface NSError(PP_Error)
- (NSString *)descriptionSummary;
@end

//正常状态
static NSInteger const kPPApiStatusNormal = 200;

@interface PPApiStatus : NSObject
@property(nonatomic,strong,readonly) NSString *code;
@property(nonatomic,strong,readonly) NSString *domain;
@property(nonatomic,strong) NSString *localizedDescription;
@property(nonatomic,strong,readonly) NSDictionary *userInfo;
@property(nonatomic,assign,readonly) BOOL normal;

- (id)initWithDomain:(NSString *)domain code:(NSString *)code userInfo:(NSDictionary *)dict;

+ (id)statusWithDomain:(NSString *)domain code:(NSString*)code userInfo:(NSDictionary *)dict;

@end

