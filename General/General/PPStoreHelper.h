//
//  PPStoreHelper.h
//  PatPat
//
//  Created by Bruce He on 15/9/10.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PPStoreHelper : NSObject
//存储到NSUserDefaults
+ (void)storeValue:(id)value forKey:(NSString *)key;

//根据key从NSUserDefaults获取值
+ (id)getValueForKey:(NSString *)key;

//存储到系统的钥匙串
+(void)systemStoreValue:(NSString *)value
                 forKey:(NSString *)key;

//根据key从系统的钥匙串获取值
+ (id)getSystemValueForKey:(NSString *)key;
@end
