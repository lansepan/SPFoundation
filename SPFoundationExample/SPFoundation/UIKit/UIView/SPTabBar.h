//
//  SPTabBar.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBarButton.h"
@class SPTabBar;

@protocol SPTabBarDelegate <NSObject>

@optional
- (void)spTabBar:(SPTabBar *)spTabBar didSelectItem:(SPBarButton *)item;

@end

@interface SPTabBar : UIView

@property (nonatomic, weak) id<SPTabBarDelegate> delegate;

- (void)addImgBg:(UIImage *)img;
- (void)addBarButton:(NSString *)normalImg disabledImg:(NSString *)disabledImg normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor title:(NSString *)title;

@end
