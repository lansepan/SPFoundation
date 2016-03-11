//
//  UINavigationItem+SPLoading.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ANNavBarLoaderPosition){
    ANNavBarLoaderPositionCenter = 0,
    ANNavBarLoaderPositionLeft,
    ANNavBarLoaderPositionRight
};

@interface UINavigationItem (SPLoading)

- (void)startAnimatingAt:(ANNavBarLoaderPosition)position;
- (void)stopAnimating;

@end
