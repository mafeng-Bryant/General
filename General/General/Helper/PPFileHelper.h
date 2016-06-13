//
//  PPFileManager.h
//  PatPat
//
//  Created by Yuan on 14/12/22.
//  Copyright (c) 2014年 http://www.patpat.com. All rights reserved.
//

#import "VFileManager.h"

@interface PPFileHelper : VFileManager

/**
 *  初始化目录
 */
+ (void)initFolder;

/**
 *  根据userid生成路径
 *
 *  @param userId 用户id
 *
 *  @return 路径
 */
+ (NSString *)userPath:(NSNumber *)userId;

/**
 *  根据filename生存文件路径
 *
 *  @param fileName 文件名
 *
 *  @return 路径
 */
+ (NSString *)configurePath:(NSString *)fileName;

//instagram file path
+ (NSString *)instagramPath:(NSString *)fileName;

+ (BOOL)saveData:(id)data name:(NSString *)name;

+ (id)readData:(NSString *)name;

@end
