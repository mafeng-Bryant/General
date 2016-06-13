//
//  Macros.h
//  General
//
//  Created by patpat on 16/6/12.
//  Copyright © 2016年 test. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#import "VMacros.h"


// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// 颜色(RGB)
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//设备判断
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define KBaiduApiKey @"x63GDHohWGaTUVsu4zOM5plqVGME5K8O"

#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])

//登陆类型
typedef enum {
    LogInTypeUnknown = 0,
    LogInTypeEmail = 1,
    LogInTypeGuest = 2,
    LogInTypeFaceBook = 3,
    LogInTypeTwitter = 4,
    LogInTypePinterest = 5
}LogInType;

static inline LogInType LoginType(NSString *string)
{
    if (isValidString(string)) {
        if ([string isEqualToString:@"facebook"]) {
            return LogInTypeFaceBook;
        }else if([string isEqualToString:@"twitter"]) {
            return LogInTypeTwitter;
        }else if([string isEqualToString:@"pinterest"]) {
            return LogInTypePinterest;
        }else if([string isEqualToString:@"email"]) {
            return LogInTypeEmail;
        }else if([string isEqualToString:@"guest"]) {
            return LogInTypeGuest;
        }
    }
    return LogInTypeUnknown;
}

static inline NSString* LoginTypeString(LogInType loginType)
{
    NSString *string = @"unknown";
    switch (loginType) {
        case LogInTypeEmail:
            string=@"email";
            break;
        case LogInTypeGuest:
            string=@"guest";
            break;
        case LogInTypeFaceBook:
            string=@"facebook";
            break;
        case LogInTypeTwitter:
            string=@"twitter";
            break;
        case LogInTypePinterest:
            string=@"pinterest";
            break;
        default:
            break;
    }
    return string;
}





#endif /* Macros_h */
