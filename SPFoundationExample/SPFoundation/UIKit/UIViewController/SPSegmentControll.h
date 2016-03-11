//
//  SPSegmentControll.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/11.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPSegmentControll;

@protocol SPSegmentControllDelegate <NSObject>

@optional
- (void)segmentControl:(SPSegmentControll *)segment didSelectedIndex:(NSInteger)index;
- (void)segmentControl:(SPSegmentControll *)segment didScrolledPersent:(CGFloat)persent;

@end

@interface SPSegmentControll : UIView

@property (nonatomic, strong) UIColor *indicatorViewColor;
@property (nonatomic, weak) id<SPSegmentControllDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray;
- (void)setSelectedIndex:(NSInteger)index;

@end
