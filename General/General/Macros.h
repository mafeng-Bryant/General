//
//  Macros.h
//  General
//
//  Created by patpat on 16/5/24.
//  Copyright © 2016年 test. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//app的identifier
#define kAppBundleIdentifier [[NSBundle mainBundle] bundleIdentifier]

//当string未nil，或null时格式化为replaceString
#define FormatString(string,replaceString) (string == nil || (NSNull *)string == [NSNull null])?replaceString:string

//obj是否是Class类型
#define ISCLASS(Class,obj)[obj isKindOfClass:[Class class]]

//判断字符串是否合法
static inline BOOL isValidString(NSString *s)
{
    return (s && ISCLASS(NSString, s) && [s length]>0)?YES:NO;
}

//判断Number是否合法
static inline BOOL isValidNumber(id n)
{
    return (n && ISCLASS(NSNumber, n))?YES:NO;
}

//判断字典是否合法
static inline BOOL isValidDictionary(NSDictionary *d)
{
    return (d && ISCLASS(NSDictionary, d))?YES:NO;
}

//判断数组是否合法
static inline BOOL isValidArray(NSArray *a)
{
    return (a && ISCLASS(NSArray, a))?YES:NO;
}

//格式化Number
static inline NSNumber * FormatNumber(NSObject *obj,id replaceNumber)
{
    NSNumber *result = replaceNumber;
    if (obj && (isValidString((NSString *)obj) || isValidNumber(obj))){
        result =  @([(NSString *)obj integerValue]);
    }
    return result;
}


#endif /* Macros_h */
