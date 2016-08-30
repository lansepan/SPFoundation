//
//  UIImage+SPSuperCompress.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIImage+SPSuperCompress.h"

@implementation UIImage (SPSuperCompress)

+ (UIImage*)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat imageW = normal.size.width * 0.5;
    CGFloat imageH = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW)];
}

+ (UIImage *)joinImages:(NSArray *)images vOrh:(BOOL)vOrh {
    if(!images || [images count] == 0){
        return nil;
    }
    
    UIImage *resultingImage = nil;
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    //计算拼接图像结果大小
    __block CGFloat width = 0;
    __block CGFloat height = 0;
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        
        //垂直
        if (vOrh)
        {
            width = MAX(image.size.width, width);
            height += image.size.height;
        }
        else
        {
            width += image.size.width;
            height = MAX(image.size.height, height);
        }
    }];
    
    CGSize resultSize = CGSizeMake(width * scale, height * scale);
    __block CGFloat lastWidth = 0;
    __block CGFloat lastHeight = 0;
    
    UIGraphicsBeginImageContextWithOptions(resultSize, NO, 0);
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop){
        
        CGFloat x = vOrh? 0 : lastWidth;
        CGFloat y  = vOrh? lastHeight : 0;
        lastWidth = image.size.width * scale;
        lastHeight = image.size.height * scale;
        CGRect frame = CGRectMake(x, y, lastWidth, lastHeight);
        [image drawInRect:frame];
    }];
    resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (UIImage *)captureView:(UIView *)view {
    if(!view){
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)captureContentScrollView:(UIScrollView *)scrollView {
    if(!scrollView){
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, [[UIScreen mainScreen] scale]);
    CGPoint savedContentOffset  = scrollView.contentOffset;
    CGRect savedFrame           = scrollView.frame;
    
    scrollView.contentOffset    = CGPointZero;
    scrollView.frame            = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    
    // 如果是tableView或者collectionView需要重新加载一下cell
    // 或许还有需要特殊处理的其他UIScrollView的子类
    if([scrollView respondsToSelector:@selector(reloadData)]) {
        [scrollView performSelector:@selector(reloadData)];
    }
    
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image              = UIGraphicsGetImageFromCurrentImageContext();
    
    scrollView.contentOffset    = savedContentOffset;
    scrollView.frame            = savedFrame;
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageFromColor:(UIColor *)imageColor {
    return [[self class] imageFromColor:imageColor frame:CGRectMake(0.0, 0.0, 1.0, 1.0)];
}

+ (UIImage *)imageFromColor:(UIColor *)imageColor frame:(CGRect)frame {
    if(!imageColor) {
        return nil;
    }
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [imageColor CGColor]);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (NSData *)compressImage:(UIImage *)image toMaxLength:(NSInteger)maxLength maxWidth:(NSInteger)maxWidth
{
    NSAssert(maxLength > 0, @"图片的大小必须大于 0");
    NSAssert(maxWidth > 0, @"图片的最大边长必须大于 0");
    
    CGSize newSize = [self scaleImage:image withLength:maxWidth];
    UIImage *newImage = [self resizeImage:image withNewSize:newSize];
    
    CGFloat compress = 0.9f;
    NSData *data = UIImageJPEGRepresentation(newImage, compress);
    
    while (data.length > maxLength && compress > 0.01) {
        compress -= 0.02f;
        
        data = UIImageJPEGRepresentation(newImage, compress);
    }
    return data;
}

+ (UIImage *) resizeImage:(UIImage *) image withNewSize:(CGSize) newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (CGSize) scaleImage:(UIImage *) image withLength:(CGFloat) imageLength
{
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (width > imageLength || height > imageLength)
    {
        if (width > height)
        {
            newWidth = imageLength;
            newHeight = newWidth * height / width;
        }
        else if(height > width)
        {
            newHeight = imageLength;
            newWidth = newHeight * width / height;
        }
        else
        {
            newWidth = imageLength;
            newHeight = imageLength;
        }
    }
    else
    {
        return CGSizeMake(width, height);
    }
    return CGSizeMake(newWidth, newHeight);
}

@end
