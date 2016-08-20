//
//  UIImage+SPExtension.m
//  SPFoundationExample
//
//  Created by BluePan on 16/8/19.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIImage+SPExtension.h"

@implementation UIImage (SPExtension)

/** 设置圆形图片(放到分类中使用) */
- (UIImage *)cutCircleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
