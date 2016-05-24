//
//  NSString+Addition.m
//  General
//
//  Created by patpat on 16/5/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFNSString+Addition.h"

@implementation NSString (Addition)

- (BOOL)isValidUrl
{
    if (self && [self isKindOfClass:[NSString class]] && self.length>7 && ([self hasPrefix:@"http"] || [self hasPrefix:@"https"])) {
        return YES;
    }
    return NO;
}

@end
