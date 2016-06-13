//
//  MFGuideSlideViewData.h
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFGuideSlideViewObject : NSObject
@property (nonatomic,strong)NSString  *imageName;
@property (nonatomic,strong)NSString  *title;
@property (nonatomic,strong)NSString  *detail;


@end

@interface MFGuideSlideViewData : NSObject

- (NSArray*)datas;

@end

@interface MFGuideSlideView : UIView
{
    UILabel* titleLbl;
    UILabel* detailLbl;
    UIImageView* imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
                       object:(MFGuideSlideViewObject*)obj;

- (void)updateSlideView:(MFGuideSlideViewObject*)obj;


@end