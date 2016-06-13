//
//  MFUserModel.m
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFUserModel.h"

@implementation MFUserModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{
             @"userId"   : @"user_id",
             @"loginId"  : @"login_id",
             @"userName": @"user_name",
             @"email"    : @"email",
             @"avatar"   : @"avatar",
             @"lastLogin": @"last_login",
             @"userToken": @"user_token",
             @"registrationDate": @"member_since",
             @"loginType": @"login_type"
             };
}

+ (NSValueTransformer *)registrationDateJSONTransformer {
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id datesp, BOOL *success, NSError *__autoreleasing *error) {
        if (isValidNumber(datesp) ||isValidString(datesp)) {
            return [NSDate dateWithTimeIntervalSince1970:[(NSNumber *)datesp doubleValue]];
        }
        return [NSDate dateWithTimeIntervalSince1970:0];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        if (date) {
            return @([date timeIntervalSince1970]);
        }
        return @(0);
    }];
}

+ (NSValueTransformer *)userIdJSONTransformer {
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id idvalue, BOOL *success, NSError *__autoreleasing *error) {
        if (isValidNumber(idvalue) || isValidString(idvalue)) {
            return @([idvalue integerValue]);
        }
        return @(0);
    } reverseBlock:^id(NSNumber *idvalue, BOOL *success, NSError *__autoreleasing *error) {
        return idvalue;
    }];
}


+ (NSValueTransformer *)loginTypeJSONTransformer {
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *str, BOOL *success, NSError *__autoreleasing *error) {
        return @(LoginType(str));
        
    } reverseBlock:^id(NSNumber *num, BOOL *success, NSError *__autoreleasing *error) {
        LogInType loginType = (isValidNumber(num))?(LogInType)[num integerValue]:LogInTypeUnknown;
        return LoginTypeString(loginType);
    }];
}


- (void)deleteCurrentUser
{
  
    
    
}

+ (MFUserModel*)readByUserId:(NSNumber*)userId
{

    return nil;

}

+ (MFUserModel*)currentUser
{

    return nil;
}

+ (void)deleteUserByUserId:(NSNumber*)userId
{


}

+ (BOOL)isCachedByUserId:(NSNumber*)userId
{

    return YES;
}

@end
