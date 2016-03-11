//
//  SPPageView.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

//广告轮播View
#import <UIKit/UIKit.h>

typedef void (^AdPageClickBlock)(NSInteger index);

@interface SPPageView : UIView

- (void)startAdsWithBlock:(NSArray *)imageArray block:(AdPageClickBlock)block;

@end
