//
//  UIImage+SPBlur.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double ImageEffectsVersionNumber;
FOUNDATION_EXPORT const unsigned char ImageEffectsVersionString[];

@interface UIImage (SPBlur)

- (UIImage *)lightImage;
- (UIImage *)extraLightImage;
- (UIImage *)darkImage;
- (UIImage *)tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)blurredImageWithRadius:(CGFloat)blurRadius;
- (UIImage *)blurredImageWithSize:(CGSize)blurSize;
- (UIImage *)blurredImageWithSize:(CGSize)blurSize
                        tintColor:(UIColor *)tintColor
            saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                        maskImage:(UIImage *)maskImage;

/**
 *  @author leon, 16-01-12 11:01:08
 *
 *  高斯模糊
 *
 *  @param blurLevel 模糊级别
 *
 *  @return 模糊后图片
 */
- (UIImage *)gaussianBlurWithBlurLevel:(CGFloat)blurLevel;

@end
