//
//  UIImage+SPSuperCompress.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SPSuperCompress)

/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;

///对指定图片进行拉伸
+ (UIImage*)resizableImage:(NSString *)name;

/**
 *  @author leon, 15-12-07 09:12:10
 *
 *  水平或者垂直拼接一组图片
 *
 *  @param images 图片组
 *  @param vOrh   如果是YES那么锤子拼接，如果是NO那么水平拼接
 *
 *  @return 拼接完成后的图片
 */
+ (UIImage *)joinImages:(NSArray *)images vOrh:(BOOL)vOrh;

+ (UIImage *)captureView:(UIView *)view;

+ (UIImage *)captureContentScrollView:(UIScrollView *)scrollView;

+ (UIImage *)imageFromColor:(UIColor *)imageColor;

+ (UIImage *)imageFromColor:(UIColor *)imageColor frame:(CGRect)frame;

@end
