//
//  PPTabBar.h
//  General
//
//  Created by patpat on 16/6/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPTabBarItem,PPTabBar;

@protocol PPTabBarItemDelegate <NSObject>

/**
 *  item if can select
 */
- (BOOL)tabBar:(PPTabBar*)tabBar shouldSelectItemAtIndex:(NSInteger)index;

/**
 *  select An item
 */
- (void)tabBar:(PPTabBar*)tabBar didSelectItemAtIndex:(NSInteger)index;

@end

@interface PPTabBar : UIView

/**
 *  PPTabBar delegate
 */
@property(nonatomic,assign) id<PPTabBarItemDelegate>delegate;

/**
 *  all items
 */
@property(nonatomic,strong) NSArray* items;

/**
 *  select item
 */
@property(nonatomic,strong) PPTabBarItem* selectedItem;

/**
 *  current view background
 */
@property(nonatomic,readonly) UIView* backgroundView;

/**
 *  item position
 */
@property UIEdgeInsets contentEdgeInsets;

/**
 * set view translucent default is NO.
 */
@property(nonatomic,assign) BOOL translucent;

- (void)setHeight:(CGFloat)height;

- (CGFloat)minimumContentHeight;


@end
