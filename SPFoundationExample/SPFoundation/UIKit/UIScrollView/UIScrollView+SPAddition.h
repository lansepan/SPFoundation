//
//  UIScrollView+SPAddition.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionLeft,
    ScrollDirectionRight,
    ScrollDirectionWTF
};

@interface UIScrollView (SPAddition)

@property(nonatomic) CGFloat contentWidth;
@property(nonatomic) CGFloat contentHeight;
@property(nonatomic) CGFloat contentOffsetX;
@property(nonatomic) CGFloat contentOffsetY;

- (CGPoint)topContentOffset;
- (CGPoint)bottomContentOffset;
- (CGPoint)leftContentOffset;
- (CGPoint)rightContentOffset;

- (ScrollDirection)ScrollDirection;

- (BOOL)isScrolledToTop;
- (BOOL)isScrolledToBottom;
- (BOOL)isScrolledToLeft;
- (BOOL)isScrolledToRight;
- (void)scrollToTopAnimated:(BOOL)animated;
- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)scrollToLeftAnimated:(BOOL)animated;
- (void)scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)verticalPageIndex;
- (NSUInteger)horizontalPageIndex;

- (void)scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;

@end
