//
//  MFGuideSlideViewData.m
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFGuideSlideViewData.h"

@implementation MFGuideSlideViewObject

@end

@implementation MFGuideSlideViewData

- (NSArray*)introductionImages
{
    return @[@"intro_icon_6",@"intro_icon_0",@"intro_icon_1",@"intro_icon_2",
             @"intro_icon_3",@"intro_icon_4",@"intro_icon_5"];
}

- (NSArray*)introductionTitles
{
    return @[@"Coding",@"精彩项目",@"任务管理",@"项目文档",@"代码托管",@"实时消息",@"趣味冒泡"];
}

- (NSArray*)introductionDetailTitles
{
    return @[@"让开发简单",@"在 coding 你可以创建任何项目",@"详细任务动态 追踪任务进度",@"云端共享，支持所有文件格式",@"查看代码合并一步到位",@"团队协作，精准快捷",@"点赞互动，分享技术开发难题"];
}

-(NSArray *)datas
{
    NSMutableArray *datas = [NSMutableArray array];
    NSArray* images = [self introductionImages];
    NSArray* titles = [self introductionTitles];
    NSArray* detailTitles = [self introductionDetailTitles];
    for (int i = 0; i < images.count; i++) {
        MFGuideSlideViewObject *obj = [[MFGuideSlideViewObject alloc]init];
        obj.title = titles[i];
        obj.detail = detailTitles[i];
        obj.imageName = images[i];
        [datas addObject:obj];
    }
     return datas;
}

@end


@implementation MFGuideSlideView

- (instancetype)initWithFrame:(CGRect)frame
                       object:(MFGuideSlideViewObject*)obj
{
    self = [super initWithFrame:frame];
    if (self) {
    
        CGSize imageSize = CGSizeMake(250, 220);
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - imageSize.width)/2.0, 0, imageSize.width, imageSize.height)];
        imageView.backgroundColor = PPC7;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = Image(obj.imageName);
        [self addSubview:imageView];
        
        titleLbl = [UILabel createLable:CGRectMake(0,imageView.bottom+VMargin55,frame.size.width,VMargin20) text:obj.title font:PPF6 textColor:PPC3 textAlignment:NSTextAlignmentCenter];
        titleLbl.numberOfLines = 0;
        [self addSubview:titleLbl];
        [titleLbl sizeToFit];
        titleLbl.x = (self.width - titleLbl.width)/2.0;
        
        detailLbl = [UILabel createLable:CGRectMake(0,titleLbl.bottom+VMargin15,frame.size.width,VMargin20) text:obj.detail font:PPF3 textColor:PPC3 textAlignment:NSTextAlignmentCenter];
        detailLbl.numberOfLines = 0;
        [self addSubview:detailLbl];
        [detailLbl sizeToFit];
        detailLbl.x = self.width/2-detailLbl.width/2;
        
        //重置view的位置
        CGFloat actualHeight = self.height;
        CGFloat willHeight = detailLbl.bottom;
        self.height = willHeight;
        CGFloat scale = 1.0;
        if (actualHeight < willHeight) {
            scale = actualHeight/willHeight;
            self.transform = CGAffineTransformScale(self.transform,scale,scale);
            willHeight = self.height;
         }
        self.y = kStatusBarHeight+(actualHeight -willHeight)/2.0;
    }
    return self;

}

- (void)updateSlideView:(MFGuideSlideViewObject*)obj
{
    titleLbl.text = obj.title;
    detailLbl.text = obj.detail;
}


@end