//
//  MFBaseModel.m
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFBaseModel.h"

@implementation MFBaseModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{};
}

- (BOOL)save
{
    return NO;
}

- (BOOL)saveToPath:(NSString*)path
{
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:path];
    if (success) {
        HYLog(@"保存成功! %@",path);
    }else{
        HYLog(@"保存失败! %@",path);
    }    return success;
}

+ (id)readByPath:(NSString*)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (NSString*)stringFormat:(id)obj
{
    if (isValidString(obj)) {
        return obj;
    }
    if (isValidNumber(obj)) {
        return [NSString stringWithFormat:@"%@",obj];
    }
    return @"";
}

@end

