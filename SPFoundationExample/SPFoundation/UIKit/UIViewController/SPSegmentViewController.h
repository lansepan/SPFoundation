//
//  SPSegmentViewController.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/11.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSegmentViewController.h"

@interface SPSegmentViewController : UIViewController

@property (nonatomic, copy) NSArray *viewControllerArray;
@property (nonatomic, copy) NSArray *titleArray;

/** 指示视图的颜色 */
@property (nonatomic, strong) UIColor *indicatorViewColor;
/** segment的背景颜色 */
@property (nonatomic, strong) UIColor *segmentBgColor;
/** segment每一项的宽 */
@property (nonatomic, assign) CGFloat itemWidth;
/** segment每一项的高 */
@property (nonatomic, assign) CGFloat itemHeight;

@end
