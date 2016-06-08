//
//  PPScrollDigitView.h
//  General
//
//  Created by patpat on 16/6/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPScrollDigitView : UIView
{
    CGFloat _oneDigitHeight;

}
@property(nonatomic,strong) UILabel* label;
@property(nonatomic,assign) NSInteger digit;

- (void)setDigitAndCommit:(NSInteger)aDigit;

- (void)setDigit:(NSInteger)aDigit from:(NSInteger)last;

- (void)setDigitFromLast:(NSInteger)aDigit;

- (void)commitChange;

- (void)didConfigFinish;




@end
