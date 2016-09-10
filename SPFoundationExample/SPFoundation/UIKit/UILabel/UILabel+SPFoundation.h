//
//  UILabel+SPFoundation.h
//  SPFoundationExample
//
//  Created by BluePan on 16/6/4.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SPFoundation)

//添加中划线
- (void)addStrikethrough;

//添加下划线
- (void)addUnderline;

/** 创建一个 */
+ (UILabel *)newSingleFrame:(CGRect)frame title:(NSString *)title fontS:(CGFloat)fonts color:(UIColor *)color;

/** 有删除线的 */
- (void)delLineStr:(NSString *)string;

/** 有下划线的 */
- (void)underlineStr:(NSString *)string;

/** 设置label的行高默认为：10 */
- (void)settingLabelHeightofRowString:(NSString*)string;

/** 设置label的行高*/
- (void)settingLabelRowOfHeight:(CGFloat)height string:(NSString*)string;

/** 设置Html代码格式Str */
- (void)htmlString:(NSString *)htmlStr;

/** 设置Html代码格式Str与行高 */
- (void)htmlString:(NSString *)htmlStr labelRowOfHeight:(CGFloat)height;

@end
