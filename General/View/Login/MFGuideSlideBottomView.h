//
//  MFGuideSlideBottomView.h
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  ActionTypeRegister = 0,
  ActionTypeLogin = 1
}ActionType;

typedef void(^actionBlock)(ActionType);

@interface MFGuideSlideBottomView : UIView

@property(nonatomic,copy) actionBlock block;

@end
