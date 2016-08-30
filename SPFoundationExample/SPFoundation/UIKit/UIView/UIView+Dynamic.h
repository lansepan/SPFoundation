//
//  UIView+Dynamic.h
//  Camera360
//
//  Created by peter on 13-11-27.
//  Copyright (c) 2013年 Pinguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Dynamic)

- (void)moveTo:(float)to toY:(float)toY duration:(float)duration completion:(void (^)(BOOL finished))completion;
- (void)dropTo:(float)to duration:(float)duration completion:(void (^)(BOOL finished))completion;
- (void)shootTo:(float)to duration:(float)duration completion:(void (^)(BOOL finished))completion;
- (void)recursiveEnumerateSubviewsUsingBlock:(void (^)(UIView *view, BOOL *stop))block;
- (void)shake:(BOOL)enable;

@end
