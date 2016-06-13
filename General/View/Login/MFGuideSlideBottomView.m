//
//  MFGuideSlideBottomView.m
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFGuideSlideBottomView.h"

@interface MFGuideSlideBottomView()
{
      UIButton* _registerBtn;
      UIButton* _signInBtn;
}

@end

@implementation MFGuideSlideBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    self.height = VMargin100;
    UIColor *darkColor = [UIColor colorWithHexString:@"0x28303b"];
    CGFloat buttonWidth = self.width*0.4;
    CGFloat buttonHeight = VMargin40;
    _registerBtn = ({
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.size = CGSizeMake(buttonWidth, buttonHeight);
        btn.backgroundColor = darkColor;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"注册" forState:UIControlStateNormal];
        ViewRadius(btn, buttonHeight/2.0);
        btn;
    });
    [self addSubview:_registerBtn];
    _signInBtn = ({
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.size = CGSizeMake(buttonWidth, buttonHeight);
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [btn setTitleColor:darkColor forState:UIControlStateNormal];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        ViewBorderRadius(btn, buttonHeight/2.0, VMargin1, darkColor);
            btn;
    });
    
    [self addSubview:_signInBtn];
     CGFloat spaceX = (self.width - buttonWidth*2)/3.0;
    _registerBtn.origin = CGPointMake(spaceX, (self.height - _registerBtn.height)/2.0);
    _signInBtn.origin = CGPointMake(CGRectGetMaxX(_registerBtn.frame)+spaceX, (self.height - _signInBtn.height)/2.0);
}



@end
