//
//  PPMapManager.h
//  General
//
//  Created by patpat on 16/6/8.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPMapManager : NSObject
{
    BMKMapManager* _mapManager;
}

+ (PPMapManager*)shareInstance;

- (void)starBaiduMap;


@end
