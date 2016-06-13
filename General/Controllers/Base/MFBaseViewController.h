//
//  MFBaseViewController.h
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UniversalDelegate <NSObject>
- (void)callBack:(id)info;
- (void)callBack:(id)info withObject:(id)info1;
- (void)callBack:(id)info withObject:(id)info1 withObject:(id)info2;

@end

@interface MFBaseViewController : UIViewController

@property(nonatomic,assign) id<UniversalDelegate>delegate;


@end
