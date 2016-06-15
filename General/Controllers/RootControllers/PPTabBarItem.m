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
                                   NSFontAttributeName:PPF0,
                                   NSForegroundColorAttributeName: [UIColor colorWithString:@"0x808080"]
                                   };
    _selectedTitleAttributes = @{NSFontAttributeName:PPF0,
                                 NSForegroundColorAttributeName: [UIColor colorWithString:@"0x3BBD79"]
                                 };
    _badgeBackgroundColor = [UIColor colorWithString:@"0xf75388"];
    _badgeTextColor = PPC7;
    _badgeTextFont = (iPhone6||iPhone6Plus)?PPF2:PPF1;
    _badgePositionOffset = UIOffsetMake(-4, 2);

}

-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    [self setNeedsDisplay];
}

- (UIImage*)finishedSelectedImage;
{
    return [self selectedImage];
}


- (UIImage*)finishUnselectedImage
{
    return [self unselectedImage];
}

- (UIImage*)backgroundSelectedImage
{
    return [self selectBackgroundImage];
}

- (UIImage*)backgroundUnSelectedImage
{
    return [self unselectBackgroundImage];
}


- (void)setFinshSelectedImage:(UIImage*)selectedImage withFinishedUnselectedImage:(UIImage*)unselectedImage
{
    
}


- (void)setBackgroundSelectedImage:(UIImage*)image withUnSelectedImage:(UIImage*)unselectedImage
{


}

-(void)drawRect:(CGRect)rect
{
    
    
    
    
    
    


}



@end
