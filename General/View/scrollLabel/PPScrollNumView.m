//
//  PPScrollNumView.m
//  General
//
//  Created by patpat on 16/6/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PPScrollNumView.h"
#import "PPScrollDigitView.h"

@implementation PPScrollNumView

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
    self.numberSize = 1;
    _numberValue = 0;
    self.spaceWidth = 2.0;
}

- (void)setNumber:(NSInteger)number  animationTime:(NSTimeInterval)timeSpan
{
    for (int i = 0; i < _numberSize; i++) {
        PPScrollDigitView* digitView = [_numberViews objectAtIndex:i];
        NSInteger digit = [PPScrollNumView digitFromNum:number withIndex:i];
        if (digit !=[self digitIndex:i]) {
            [digitView setDigitFromLast:digit];
        }
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:timeSpan];
    
    for (PPScrollDigitView* digitView in _numberViews) {
        [digitView commitChange];
    }
    [UIView commitAnimations];
    _numberValue = number;
}

+ (NSInteger)digitFromNum:(NSInteger)number withIndex:(NSInteger)index{
    NSInteger num = number;
    for (int i = 0; i < index ; i++) {
        num/=10;
    }
    return num%10;
}

- (NSInteger)digitIndex:(NSInteger)index
{
    return [PPScrollNumView digitFromNum:self.numberValue withIndex:index];
}

- (void)removeDigitView
{
    for (UIView* digitView  in self.subviews) {
        if ([digitView isKindOfClass:[PPScrollDigitView class]]) {
            [digitView removeFromSuperview];
        }
    }
}

- (void)didConfigFinish
{
    [self removeDigitView];
    _numberViews = [NSMutableArray arrayWithCapacity:self.numberSize];
    CGFloat allWidth = self.frame.size.width;
    CGFloat digitWidth = allWidth /self.numberSize;
    for (int i = 0 ; i < self.numberSize; i++) {
        CGRect rect = {{allWidth - digitWidth * (i + 1), 2}, {digitWidth, self.frame.size.height - 2 * 2}};
        PPScrollDigitView* digitView = [[PPScrollDigitView alloc]initWithFrame:rect];
        [digitView didConfigFinish];
        [digitView setDigitAndCommit:[self digitIndex:i]];
        [_numberViews addObject:digitView];
        [self addSubview:digitView];
    }    
}

#pragma mark set and get method

-(void)layoutSubviews
{
    [super layoutSubviews];
  
}



@end
