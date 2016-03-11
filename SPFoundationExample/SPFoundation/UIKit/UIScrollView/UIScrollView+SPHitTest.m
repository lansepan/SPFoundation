//
//  UIScrollView+SPHitTest.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIScrollView+SPHitTest.h"

@implementation UIScrollView (SPHitTest)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *result = [super hitTest:point withEvent:event] ;
    if ([result isKindOfClass:[UISlider class]])
    {
        self.scrollEnabled = NO ;
    }
    else
    {
        self.scrollEnabled = YES ;
    }
    return result ;
}

@end
