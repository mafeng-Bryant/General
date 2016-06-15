//
//  MFIntroductionController.m
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFIntroductionController.h"
#import "PPPageControl.h"
#import "MFGuideSlideViewData.h"
#import "MFGuideSlideBottomView.h"
#import "MFLoginViewController.h"
#import "MFRegisterViewController.h"
#import "MFBaseNavigationController.h"

@interface MFIntroductionController ()<UIScrollViewDelegate>
{
    NSArray* _slideDatas;
    NSInteger _currentPage;
    CGFloat _lastContentOffsetX;
}
@property(nonatomic,strong) UIScrollView* contentScrollView;
@property(nonatomic,strong) MFGuideSlideViewData* slideData;
@property(nonatomic,strong) PPPageControl* pageControl;
@property(nonatomic,strong) MFGuideSlideBottomView* bottomView;

@end

@implementation MFIntroductionController

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.contentScrollView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.bottomView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PPC7;
    [self lodeSlideData];
}


#pragma mark Private method

- (void)lodeSlideData
{
    NSArray* datas = [self.slideData datas];
    if (!datas) return;
    _slideDatas = datas;
    CGFloat height = _bottomView.y - kStatusBarHeight - VMargin30;
    [_contentScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _contentScrollView.contentSize = CGSizeZero;
    for (int i = 0; i < datas.count; i++) {
        MFGuideSlideViewObject* obj = [datas objectAtIndex:i];
        CGRect rect = CGRectMake(_contentScrollView.width*i, 0, _contentScrollView.width, height);
        MFGuideSlideView* view = [[MFGuideSlideView alloc]initWithFrame:rect object:obj];
        view.tag = 1000+i;
        view.backgroundColor = [UIColor clearColor];
        [_contentScrollView addSubview:view];
    }
    _contentScrollView.contentSize = CGSizeMake(datas.count*_contentScrollView.width, _contentScrollView.height);
    _pageControl.centerX = self.view.centerX;
    _pageControl.numberOfPages = datas.count;
    _pageControl.size = CGSizeMake(VMargin10, VMargin10);
    _pageControl.y = self.view.height-_bottomView.height-_pageControl.height-VMargin20;
    
}

#pragma mark Setter and Getter

-(MFGuideSlideViewData *)slideData
{
    if (!_slideData) {
        _slideData = [[MFGuideSlideViewData alloc]init];
    }
    return _slideData;
}

-(UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _contentScrollView.backgroundColor = [UIColor clearColor];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentScrollView;
}

- (PPPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[PPPageControl alloc] init] ;
        _pageControl.frame = CGRectMake(0, 0,VMargin10,VMargin10);
        [_pageControl setCurrentPage: 0] ;
        [_pageControl setDefersCurrentPageDisplay: YES] ;
        [_pageControl setType: PPPageControlTypeOnFullOffFull];
        [_pageControl setOnColor:PPC3];
        [_pageControl setOffColor:RGB(68,68,68,0.15)];
        [_pageControl setIndicatorDiameter: 8.0f] ;
        [_pageControl setIndicatorSpace: 15.0f];
        [_pageControl setNumberOfPages:0];
    }
    return _pageControl;
}

-(MFGuideSlideBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[MFGuideSlideBottomView alloc]initWithFrame:self.view.bounds];
        _bottomView.backgroundColor = [UIColor clearColor];
        __weak MFIntroductionController *weakSelf = self;
        _bottomView.block = ^(ActionType type){
            if (type == ActionTypeRegister) {
                MFRegisterViewController* registerVC = [[MFRegisterViewController alloc]initWithRegisterType:RegisterTypePhone];
                MFBaseNavigationController* nav = [[MFBaseNavigationController alloc]initWithRootViewController:registerVC];
                [weakSelf presentViewController:nav animated:YES completion:nil];
            }else if (type ==ActionTypeLogin){
                MFLoginViewController* loginVC = [[MFLoginViewController alloc]initWithNibName:@"MFLoginViewController" bundle:nil];
                MFBaseNavigationController* nav = [[MFBaseNavigationController alloc]initWithRootViewController:loginVC];
                [weakSelf presentViewController:nav animated:YES completion:nil];
            }
        };
    }
    _bottomView.y = self.view.height - _bottomView.height;
    return _bottomView;
}

#pragma mark UIScrollView delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger scrollPhotoNumber = MAX(0, MIN(_slideDatas.count-1, (int)(scrollView.contentOffset.x / scrollView.width)));
    if(scrollPhotoNumber != _currentPage) {
        _currentPage = scrollPhotoNumber;
    }
    float offset =  scrollView.contentOffset.x - (_currentPage * scrollView.width);
    if(offset < 0) {
        offset = scrollView.width - MIN(-offset, scrollView.width);
        CGFloat alpha = offset/scrollView.width;
        MFGuideSlideView* currentView = (MFGuideSlideView*)[scrollView viewWithTag:1000+_currentPage];
        [UIView animateWithDuration:0.25 animations:^{
            currentView.alpha = alpha;
        }];
    } else if(offset != 0) {
        if(scrollPhotoNumber == _slideDatas.count-1) {
            CGFloat alpha = 1 - offset/scrollView.width;
            MFGuideSlideView* currentView = (MFGuideSlideView*)[scrollView viewWithTag:1000+_currentPage];
            [UIView animateWithDuration:0.25 animations:^{
                currentView.alpha = alpha;
            }];
        } else {
            if (_lastContentOffsetX > scrollView.contentOffset.x)
            {
                CGFloat alpha = 1 - offset/scrollView.width;
                MFGuideSlideView* currentView = (MFGuideSlideView*)[scrollView viewWithTag:1000+_pageControl.currentPage];
                MFGuideSlideView* preView = (MFGuideSlideView*)[scrollView viewWithTag:1000+_pageControl.currentPage-1];
                [UIView animateWithDuration:0.25 animations:^{
                    preView.alpha = alpha;
                    currentView.alpha = 1- alpha;
                }];
                
            }else if (_lastContentOffsetX < scrollView.contentOffset.x)
            {
                CGFloat alpha = 1 - offset/scrollView.width;
                MFGuideSlideView* currentView = (MFGuideSlideView*)[scrollView viewWithTag:1000+_pageControl.currentPage];
                MFGuideSlideView* nextView = (MFGuideSlideView*)[scrollView viewWithTag:1000+_pageControl.currentPage+1];
                [UIView animateWithDuration:0.25 animations:^{
                    currentView.alpha = alpha;
                    nextView.alpha = 1- alpha;
                }];
                
            }
            _lastContentOffsetX = scrollView.contentOffset.x;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = (scrollView.contentOffset.x  + scrollView.frame.size.width )/ scrollView.frame.size.width-1;
    currentPage = MAX(currentPage,0);
    [self setCurrentPage:currentPage];
    [UIView animateWithDuration:0.25 animations:^{
        for (UIView* view in scrollView.subviews) {
            if ([view isKindOfClass:[MFGuideSlideView class]]) {
                view.alpha = 1.0;
            }
        }
     }];
}

- (void)setCurrentPage:(NSInteger)page
{
    _pageControl.currentPage = page;
    [_pageControl setOnColor:PPC3];
    [_pageControl setOffColor:RGB(218.0, 221.0, 222.0, 1.0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
