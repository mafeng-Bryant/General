//
//  PPPageControl.h
//  PatPat
//
//  Created by patpat on 15/7/24.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIKitDefines.h>

typedef enum
{
	PPPageControlTypeOnFullOffFull		= 0,
	PPPageControlTypeOnFullOffEmpty		= 1,
	PPPageControlTypeOnEmptyOffFull		= 2,
	PPPageControlTypeOnEmptyOffEmpty	= 3,
}
PPPageControlType ;


@interface  PPPageControl: UIControl
{
	NSInteger numberOfPages ;
	NSInteger currentPage ;
}

@property(nonatomic) NSInteger numberOfPages ;
@property(nonatomic) NSInteger currentPage ;

@property(nonatomic) BOOL hidesForSinglePage ;

@property(nonatomic) BOOL defersCurrentPageDisplay ;
- (void)updateCurrentPageDisplay ;

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount ;

- (id)initWithType:(PPPageControlType)theType ;

@property (nonatomic) PPPageControlType type ;
@property (nonatomic,retain) UIColor *onColor ;
@property (nonatomic,retain) UIColor *offColor ;

@property (nonatomic) CGFloat indicatorDiameter ;//半径
@property (nonatomic) CGFloat indicatorSpace ;//间距

@end

