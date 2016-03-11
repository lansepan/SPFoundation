//
//  UIWebView+SPFoundation.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIWebView+SPFoundation.h"

@implementation UIWebView (SPFoundation)

- (NSString *)documentTitle
{
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

//网页内容自适应
- (void)fixViewPort
{
    NSString* js =
    @"var meta = document.createElement('meta'); "
    "meta.setAttribute( 'name', 'viewport' ); "
    "meta.setAttribute( 'content', 'width = device-width' ); "
    "document.getElementsByTagName('head')[0].appendChild(meta)";
    [self stringByEvaluatingJavaScriptFromString: js];
}

//清除默认背景高光
- (void)cleanBackground
{
    self.backgroundColor = [UIColor clearColor];
    for (UIView *view in [[[self subviews] objectAtIndex:0] subviews])
    {
        if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
    }
}

@end
