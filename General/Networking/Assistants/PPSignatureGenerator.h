//
//  PPSignatureGenerator.h
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSignatureGenerator : NSObject

+ (NSString *)generateSignatureWithParameters:(NSDictionary *)allParameters;

@end
