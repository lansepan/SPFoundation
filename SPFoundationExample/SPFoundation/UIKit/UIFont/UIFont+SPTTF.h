//
//  UIFont+SPTTF.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (SPTTF)

+ (UIFont *)fontWithTTFAtPath:(NSString *)path size:(CGFloat)size;

+ (UIFont *)fontWithTTFAtURL:(NSURL *)URL size:(CGFloat)size;

+ (UIFont *)customFontOfSize:(CGFloat)size withName:(NSString *)name withExtension:(NSString *)extension;

+ (UIFont *)customFontWithURL:(NSURL *)fontURL size:(CGFloat)size;

+ (NSArray *)registerFontFromURL:(NSURL *)fontURL;

@end
