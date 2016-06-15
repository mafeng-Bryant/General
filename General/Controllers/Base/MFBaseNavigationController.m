//
//  MFBaseNavigationController.m
//  General
//
//  Created by patpat on 16/6/14.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFBaseNavigationController.h"

@interface MFBaseNavigationController ()

@end

@implementation MFBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0x28303b"]] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTintColor:[UIColor whiteColor]];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName:PPF4,
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
    [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];//设置UITextField的光标颜色
    [[UITextView appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];//设置UITextView的光标颜色
    UIImage* image = [UIImage imageWithColor:[UIColor colorWithString:@"0xeeeeee"]];
    [[UISearchBar appearance] setBackgroundImage:image forBarPosition:0 barMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
