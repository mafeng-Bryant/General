//
//  PPTabBarController.h
//  General
//
//  Created by patpat on 16/6/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTabBar.h"

@protocol PPTabBarControllerDelegate;

@interface PPTabBarController : UIViewController

/**
 *  An array of root view controllers
 */
@property(nonatomic,strong) IBOutletCollection(UIViewController) NSArray* viewControllers;

/**
 *  currently dispaly viewController
 */
@property(nonatomic,weak) UIViewController* selectedViewController;

/**
 *  select tab item
 */
@property(nonatomic) NSUInteger selectedIndex;

/**
 *  hidden tabBar
 */
@property(nonatomic,assign) BOOL tabBarHidden;

/**
 *  bottom tabBar
 */
@property(nonatomic,readonly) PPTabBar* tabBar;

/**
 *  controller delegate
 */
@property(nonatomic,assign) id<PPTabBarControllerDelegate>delegate;

/**
 *  hidden tabBar show or hidden
 */
- (void)setTabBarHidden:(BOOL)tabBarHidden animated:(BOOL)animated;


@end

@protocol PPTabBarControllerDelegate <NSObject>

@optional

/**
 *  ask delegate can select viewController
 */

- (BOOL)tabBarController:(PPTabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewController;

/**
 *  select An viewController
 */
- (void)tabBarController:(PPTabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController;


@end

@interface UIViewController(PPTabBarControllerItem)

@property(nonatomic,strong) PPTabBarItem* pp_tabBarItem;

@property(nonatomic,readonly) PPTabBarController* pp_tabBarController;

@end





