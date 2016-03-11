//
//  UIWebView+SPFoundation.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (SPFoundation)

- (NSString *)documentTitle;
- (void)fixViewPort;//网页内容自适应
- (void)cleanBackground;//清除默认背景高光

@end
