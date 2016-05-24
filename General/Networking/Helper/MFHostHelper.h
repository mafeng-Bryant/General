//
//  PPUrlManager.h
//  PatPat
//
//  Created by patpat on 15/3/10.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MFHostTypeTest,
    MFHostTypeProduct
}MFHostType;

#define kStatgeHost @"https://api.patpat.com/V1.3"

@interface MFHostObject : NSObject
@property(nonatomic,strong)NSString *host;
@property(nonatomic,strong)NSString *title;
@property(nonatomic)MFHostType type;
@end

@interface MFHostHelper : NSObject


+ (MFHostHelper *)sharedInstance;

/**
 *  所有host
 *
 *  @return host的集合
 */
+ (NSArray *)hosts;

/**
 *  设置host
 *
 *  @param host
 */
+ (void)setHost:(NSString *)host;

/**
 *  读取设置的host
 *
 *  @return NSString
 */
+ (NSString *)getHost;

/**
 *  获取当前的server host
 *
 *  @return NSString
 */
+ (NSString *)currentServerHost;

/**
 *  改变url
 *
 *  @return void
 */
- (void)changeUrl;

@end
