//
//  PPScrollNumView.h
//  General
//
//  Created by patpat on 16/6/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPScrollNumView : UIView
{
    NSMutableArray* _numberViews;
}

@property(nonatomic,assign) NSInteger numberSize;
@property(nonatomic,assign) CGFloat spaceWidth;
@property(nonatomic,assign) NSInteger numberValue;
@property(nonatomic,strong) NSArray* numberViews;

- (void)setNumber:(NSInteger)number  animationTime:(NSTimeInterval)timeSpan;

- (void)didConfigFinish;


@end
