//
//  PPPageControl.h
//  PatPat
//
//  Created by patpat on 15/7/24.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPPageControl.h"

#define kDotDiameter	4.0f
#define kDotSpace		12.0f

@implementation PPPageControl

@synthesize numberOfPages ;
@synthesize currentPage ;
@synthesize hidesForSinglePage ;
@synthesize defersCurrentPageDisplay ;

@synthesize type ;
@synthesize onColor ;
@synthesize offColor ;
@synthesize indicatorDiameter ;
@synthesize indicatorSpace ;

#pragma mark -
#pragma mark Initializers - dealloc

- (id)initWithType:(PPPageControlType)theType
{
	self = [self initWithFrame: CGRectZero] ;
	[self setType: theType] ;
	return self ;
}

- (id)init
{
	self = [self initWithFrame: CGRectZero] ;
	return self ;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame: CGRectZero]))
	{
		self.backgroundColor = [UIColor clearColor] ;
	}
	return self ;
}

#pragma mark drawRect

- (void)drawRect:(CGRect)rect 
{
	// get the current context
	CGContextRef context = UIGraphicsGetCurrentContext() ;
	
	// save the context
	CGContextSaveGState(context) ;
	
	// allow antialiasing
	CGContextSetAllowsAntialiasing(context, TRUE) ;
	
	// get the caller's diameter if it has been set or use the default one 
	CGFloat diameter = (indicatorDiameter > 0) ? indicatorDiameter : kDotDiameter ;
	CGFloat space = (indicatorSpace > 0) ? indicatorSpace : kDotSpace ;
	
	// geometry
	CGRect currentBounds = self.bounds ;
	CGFloat dotsWidth = self.numberOfPages * diameter + MAX(0, self.numberOfPages - 1) * space ;
	CGFloat x = CGRectGetMidX(currentBounds) - dotsWidth / 2 ;
	CGFloat y = CGRectGetMidY(currentBounds) - diameter / 2 ;
	
	// get the caller's colors it they have been set or use the defaults
	CGColorRef onColorCG = onColor ? onColor.CGColor : [UIColor colorWithWhite: 1.0f alpha: 1.0f].CGColor ;
	CGColorRef offColorCG = offColor ? offColor.CGColor : [UIColor colorWithWhite: 0.7f alpha: 0.5f].CGColor ;
	
	// actually draw the dots
	for (int i = 0 ; i < numberOfPages ; i++)
	{
		CGRect dotRect = CGRectMake(x, y, diameter, diameter) ;
		
		if (i == currentPage)
		{
			if (type == PPPageControlTypeOnFullOffFull || type == PPPageControlTypeOnFullOffEmpty)
			{
				CGContextSetFillColorWithColor(context, onColorCG) ;
				CGContextFillEllipseInRect(context, CGRectInset(dotRect, -0.5f, -0.5f)) ;
			}
			else
			{
				CGContextSetStrokeColorWithColor(context, onColorCG) ;
				CGContextStrokeEllipseInRect(context, dotRect) ;
			}
		}
		else
		{
			if (type == PPPageControlTypeOnEmptyOffEmpty || type == PPPageControlTypeOnFullOffEmpty)
			{
				CGContextSetStrokeColorWithColor(context, offColorCG) ;
				CGContextStrokeEllipseInRect(context, dotRect) ;
			}
			else
			{
				CGContextSetFillColorWithColor(context, offColorCG) ;
				CGContextFillEllipseInRect(context, CGRectInset(dotRect, -0.5f, -0.5f)) ;
			}
		}
		
		x += diameter + space ;
	}
	
	// restore the context
	CGContextRestoreGState(context) ;
}


#pragma mark -
#pragma mark Accessors

- (void)setCurrentPage:(NSInteger)pageNumber
{
	if (currentPage == pageNumber)
		return ;
	
	currentPage = MIN(MAX(0, pageNumber), numberOfPages - 1) ;
	
	if (self.defersCurrentPageDisplay == NO)
		[self setNeedsDisplay] ;
}

- (void)setNumberOfPages:(NSInteger)numOfPages
{
	numberOfPages = MAX(0, numOfPages) ;
	
	currentPage = MIN(MAX(0, currentPage), numberOfPages - 1) ;
	
	self.bounds = self.bounds ;
	
	[self setNeedsDisplay] ;
	
    if (hidesForSinglePage && (numOfPages < 2))
		[self setHidden: YES] ;
	else
		[self setHidden: NO] ;
}

- (void)setHidesForSinglePage:(BOOL)hide
{
	hidesForSinglePage = hide ;
	
	if (hidesForSinglePage && (numberOfPages < 2))
		[self setHidden: YES] ;
}

- (void)setDefersCurrentPageDisplay:(BOOL)defers
{
	defersCurrentPageDisplay = defers ;
}

- (void)setType:(PPPageControlType)aType
{
	type = aType ;
	
	[self setNeedsDisplay] ;
}

- (void)setOnColor:(UIColor *)aColor
{
	
	onColor = aColor ;
	
	[self setNeedsDisplay] ;
}

- (void)setOffColor:(UIColor *)aColor
{
 
	offColor = aColor ;
	
	[self setNeedsDisplay] ;
}

- (void)setIndicatorDiameter:(CGFloat)aDiameter
{
	indicatorDiameter = aDiameter ;
	
	self.bounds = self.bounds ;
	
	[self setNeedsDisplay] ;
}

- (void)setIndicatorSpace:(CGFloat)aSpace
{
	indicatorSpace = aSpace ;
	
	self.bounds = self.bounds ;
	
	[self setNeedsDisplay] ;
}

- (void)setFrame:(CGRect)aFrame
{
	aFrame.size = [self sizeForNumberOfPages: numberOfPages] ;
	super.frame = aFrame ;
}

- (void)setBounds:(CGRect)aBounds
{
	aBounds.size = [self sizeForNumberOfPages: numberOfPages] ;
	super.bounds = aBounds ;
}



#pragma mark -
#pragma mark UIPageControl methods

- (void)updateCurrentPageDisplay
{
	if (self.defersCurrentPageDisplay == NO)
		return ;
	
    [self setNeedsDisplay] ;
}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
	CGFloat diameter = (indicatorDiameter > 0) ? indicatorDiameter : kDotDiameter ;
	CGFloat space = (indicatorSpace > 0) ? indicatorSpace : kDotSpace ;
	
	return CGSizeMake(pageCount * diameter + (pageCount - 1) * space + 44.0f, MAX(44.0f, diameter + 4.0f)) ;
}


#pragma mark -
#pragma mark Touches handlers

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *theTouch = [touches anyObject] ;
	CGPoint touchLocation = [theTouch locationInView: self] ;
	
	if (touchLocation.x < (self.bounds.size.width / 2))
		self.currentPage = MAX(self.currentPage - 1, 0) ;
	else
		self.currentPage = MIN(self.currentPage + 1, numberOfPages - 1) ;
	
	[self sendActionsForControlEvents: UIControlEventValueChanged] ;
}

@end