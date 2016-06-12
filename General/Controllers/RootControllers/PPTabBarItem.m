//
//  PPTabBarItem.m
//  General
//
//  Created by patpat on 16/6/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PPTabBarItem.h"


@interface PPTabBarItem()
{
    NSString* _title;
    UIOffset _imagePositionOffset;
    NSDictionary* _unselectedTitleAttributes;
    NSDictionary* _selectedTitleAttributes;
}
@property(nonatomic,strong) UIImage* unselectBackgroundImage;
@property(nonatomic,strong) UIImage* selectBackgroundImage;
@property(nonatomic,strong) UIImage* unselectedImage;
@property(nonatomic,strong) UIImage* selectedImage;

@end


@implementation PPTabBarItem

-(instancetype)init
{
    return [super initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
   self.backgroundColor = [UIColor clearColor];
   _title = @"";
   _titleOffset = UIOffsetZero;
    
    _unselectedTitleAttributes = @{
                                   NSFontAttributeName:[UIFont systemFontOfSize:10]
                                 };
    
   
    
    
    
    
    
    
    

}



@end
