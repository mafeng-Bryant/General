//
//  PPTabBarController.m
//  General
//
//  Created by patpat on 16/6/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PPTabBarController.h"

@interface PPTabBarController ()
{
    UIView* _contentView;
}
@property(nonatomic,readwrite) PPTabBar* tabBar;

@end

@implementation PPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[self contentView]];
    [self.view addSubview:[self tabBar]];
    
}

#pragma mark set and get method

- (UIView*)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor redColor];
        [_contentView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|
        UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|
        UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin];
     }
    return _contentView;
}

-(PPTabBar *)tabBar
{
    if (!_tabBar) {
        _tabBar = [[PPTabBar alloc]init];
        _tabBar.backgroundColor = [UIColor yellowColor];
        [_tabBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth|
         UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|
         UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin];
    }
    return _tabBar;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
