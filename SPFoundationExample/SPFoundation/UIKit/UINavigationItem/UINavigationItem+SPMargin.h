//
//  UINavigationItem+SPMargin.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double UINavigationItem_MarginVersionNumber;
FOUNDATION_EXPORT const unsigned char UINavigationItem_MarginVersionString[];

@interface UINavigationItem (SPMargin)

@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;

+ (CGFloat)systemMargin;

/**
 *  @brief  锁定RightItem
 *
 *  @param lock 是否锁定
 */
- (void)lockRightItem:(BOOL)lock;

/**
 *  @brief  锁定LeftItem
 *
 *  @param lock 是否锁定
 */
- (void)lockLeftItem:(BOOL)lock;

@end
