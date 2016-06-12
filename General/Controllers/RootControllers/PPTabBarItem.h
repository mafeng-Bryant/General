//
//  PPTabBarItem.h
//  General
//
//  Created by patpat on 16/6/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPTabBarItem : UIControl

/**
 *  current item height equal tabbar height
 */
@property(nonatomic) CGFloat itemHeight;

/**
 *  every item title
 */
@property(nonatomic,copy) NSString* title;

/**
 *  title offset
 */
@property(nonatomic) UIOffset titleOffset;

/**
 *  unselected title attributes
 */
@property(nonatomic,strong) NSDictionary* unselectedTitleAttributes;

/**
 *  selected title attributes
 */
@property(nonatomic,strong) NSDictionary* selectedTitleAttributes;

/**
 *  image position offset
 */
@property (nonatomic) UIOffset imagePositionOffset;

/**
 *  set select item image
 */
- (UIImage*)finishedSelectedImage;

/**
 *  set unselect item image
 */
- (UIImage*)finishUnselectedImage;

/**
 *  set select and unselect image
 */
- (void)setFinshSelectedImage:(UIImage*)selectedImage withFinishedUnselectedImage:(UIImage*)unselectedImage;

/**
 *  set all item back image
 */
- (UIImage*)backgroundSelectedImage;

/**
 *  set all unselect item back image
 */
- (UIImage*)backgroundUnSelectedImage;

/**
 *  set background image
 */
- (void)setBackgroundSelectedImage:(UIImage*)image withUnSelectedImage:(UIImage*)unselectedImage;

/**
 *  badge value
 */
@property(nonatomic,copy) NSString* badgeValue;

/**
 *  set badge background image
 */
@property(nonatomic,strong) UIImage* badgeBackgroundImage;

/**
 *  set badge background color
 */
@property(nonatomic,strong) UIColor* badgeBackgroundColor;

/**
 *  set badge text color
 */
@property(nonatomic,strong) UIColor* badgeTextColor;

/**
 *  set badge position
 */
@property(nonatomic) UIOffset badgePositionOffset;

/**
 *  set badge text font
 */
@property(nonatomic,strong) UIFont* badgeTextFont;


@end
