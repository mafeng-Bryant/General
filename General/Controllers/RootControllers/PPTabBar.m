//
//  PPTabBar.m
//  General
//
//  Created by patpat on 16/6/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PPTabBar.h"
#import "PPTabBarItem.h"

@interface PPTabBar()
@property (nonatomic) CGFloat itemWidth;
@property (nonatomic) UIView* backgroundView;

@end

@implementation PPTabBar

-(instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)configure
{
    _backgroundView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:_backgroundView];
    [self setTranslucent:NO];
}


- (void)setItemWidth:(CGFloat)itemWidth
{
    if (itemWidth > 0) {
        _itemWidth = itemWidth;
    }
}

- (void)setItems:(NSArray *)items
{
    for (PPTabBarItem* item in items) {
        [item removeFromSuperview];
    }
    _items = [items copy];
    
    for (PPTabBarItem* item  in items) {
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:item];
    }
}

-(void)setHeight:(CGFloat)height
{
  [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), height)];
}

- (CGFloat)minimumContentHeight
{
    CGFloat mimiTabBarContentHeight = CGRectGetHeight(self.frame);
    for (PPTabBarItem* item in [self items]) {
        CGFloat itemHeight = [item itemHeight];
        if (itemHeight && itemHeight < mimiTabBarContentHeight) {
            mimiTabBarContentHeight = itemHeight;
        }
     }
    return mimiTabBarContentHeight;
}

- (void)clickItem:(id)sender
{
  
    
    

}

- (void)setTranslucent:(BOOL)translucent
{
    _translucent = translucent;
    CGFloat alpha = translucent?0.9:1.0;
    [_backgroundView setBackgroundColor:[UIColor colorWithRed:245/255.0
                                                        green:245/255.0
                                                         blue:245/255.0
                                                        alpha:alpha]];

}

-(void)layoutSubviews
{
  
    
    
    
    

}


@end
