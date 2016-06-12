//
//  PPTabBarController.m
//  General
//
//  Created by patpat on 16/6/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PPTabBarController.h"

@interface PPTabBarController ()<PPTabBarItemDelegate>
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setSelectedIndex:self.selectedIndex];
}

#pragma mark set and get method

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex>=self.viewControllers.count) {
        return;
    }
    if (self.selectedViewController) {
        [self.selectedViewController willMoveToParentViewController:nil];
        [self.selectedViewController.view removeFromSuperview];
        [self.selectedViewController removeFromParentViewController];
    }
    _selectedIndex = selectedIndex;
    [[self tabBar] setSelectedItem:[[self tabBar] items][selectedIndex]];
    
    [self setSelectedViewController:[[self viewControllers] objectAtIndex:selectedIndex]];
    [self addChildViewController:self.selectedViewController];
    [[self selectedViewController].view setFrame:[self contentView].bounds];
    [[self contentView] addSubview:self.selectedViewController.view];
    [self.selectedViewController didMoveToParentViewController:self];
}

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
        _tabBar.delegate = self;
    }
    return _tabBar;
}


- (void)setTabBarHidden:(BOOL)tabBarHidden animated:(BOOL)animated
{
 
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
