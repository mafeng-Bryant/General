//
//  PPScrollDigitView.m
//  General
//
//  Created by patpat on 16/6/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PPScrollDigitView.h"

#define kDigitViewHeight 16

@implementation PPScrollDigitView

- (void)commitChange
{
    CGRect rect = self.label.frame;
    rect.origin.y = _oneDigitHeight - rect.size.height;
    self.label.frame = rect;
}

- (void)setDigitAndCommit:(NSInteger)aDigit
{
    self.label.text = [NSString stringWithFormat:@"%ld",(long)aDigit];
    CGRect rect = self.label.frame;
    rect.origin.y = 0;
    rect.size.height = _oneDigitHeight;
    self.label.numberOfLines = 1;
    self.label.frame = rect;
    _digit = aDigit;
}

- (void)setDigit:(NSInteger)aDigit from:(NSInteger)last
{
    if (aDigit ==last) {
        [self setDigitAndCommit:aDigit];
        return;
    }
    NSMutableString *str = [NSMutableString stringWithFormat:@"%ld", (long)last];
    int count = 1;
    if (aDigit > last) {
        for (NSInteger i = last + 1; i < aDigit + 1; ++i) {
            ++count;
            [str appendFormat:@"\n%ld", (long)i];
        }
    } else {
        for (NSInteger i = last + 1; i < 10; ++i) {
            ++count;
            [str appendFormat:@"\n%ld", (long)i];
        }
        for (int i = 0; i < aDigit + 1; ++i) {
            ++count;
            [str appendFormat:@"\n%d", i];
        }
    }
    self.label.text = str;
    self.label.numberOfLines = count;
    CGRect rect = self.label.frame;
    rect.origin.y = 0;
    rect.size.height = _oneDigitHeight * count;
    self.label.frame = rect;
    _digit = aDigit;
}

- (void)setDigitFromLast:(NSInteger)aDigit
{
    [self setDigit:aDigit from:self.digit];
}

- (void)didConfigFinish
{
    
    CGSize size = [@"8" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:50.0f]}];
    _oneDigitHeight = size.height;
    
    CGRect rect = {{(self.frame.size.width - size.width) / 2, (self.frame.size.height - size.height) / 2}, size};
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
    view.clipsToBounds = YES;
    rect.origin.x = 0;
    rect.origin.y = 0;
    self.label = [[UILabel alloc] initWithFrame:rect];
    self.label.font = [UIFont systemFontOfSize:50];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor clearColor];
    self.label.backgroundColor = [UIColor redColor];
    [view addSubview:self.label];
    [self addSubview:view];
    [self setDigitAndCommit:self.digit];
    CGRect viewFrame = self.frame;
    viewFrame.size =  CGSizeMake(size.width, size.height);
    self.frame = viewFrame;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
//    CGPoint point = self.label.center;
  //  point.y = self.center.y;
}


@end
