//
//  UIImage+SPCapture.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIImage+SPCapture.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (SPCapture)

/**
 *  @brief  截图指定view成图片
 *
 *  @param view 一个view
 *
 *  @return 图片
 */
+ (UIImage *)captureWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [UIScreen mainScreen].scale);
    // IOS7及其后续版本
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    } else { // IOS7之前的版本
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

+ (UIImage *)getImageWithSize:(CGRect)myImageRect FromImage:(UIImage *)bigImage
{
    //大图bigImage
    //定义myImageRect，截图的区域
    CGImageRef imageRef = bigImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = CGRectGetWidth(myImageRect);
    size.height = CGRectGetHeight(myImageRect);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}

/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param aView    指定的view
 *  @param maxWidth 宽的大小 0为view默认大小
 *
 *  @return 截图
 */
+ (UIImage *)screenshotWithView:(UIView *)aView limitWidth:(CGFloat)maxWidth{
    CGAffineTransform oldTransform = aView.transform;
    
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    if (!isnan(maxWidth) && maxWidth>0) {
        CGFloat maxScale = maxWidth/CGRectGetWidth(aView.frame);
        CGAffineTransform transformScale = CGAffineTransformMakeScale(maxScale, maxScale);
        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
        
    }
    if(!CGAffineTransformEqualToTransform(scaleTransform, CGAffineTransformIdentity)){
        aView.transform = scaleTransform;
    }
    
    CGRect actureFrame = aView.frame; //已经变换过后的frame
    CGRect actureBounds= aView.bounds;//CGRectApplyAffineTransform();
    
    //begin
    UIGraphicsBeginImageContextWithOptions(actureFrame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1, -1);
    CGContextTranslateCTM(context,actureFrame.size.width/2, actureFrame.size.height/2);
    CGContextConcatCTM(context, aView.transform);
    CGPoint anchorPoint = aView.layer.anchorPoint;
    CGContextTranslateCTM(context,
                          -actureBounds.size.width * anchorPoint.x,
                          -actureBounds.size.height * anchorPoint.y);
    if([aView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [aView drawViewHierarchyInRect:aView.bounds afterScreenUpdates:NO];
    }
    else
    {
        [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //end
    aView.transform = oldTransform;
    
    return screenshot;
}

- (UIImage *)compressImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"compress image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
