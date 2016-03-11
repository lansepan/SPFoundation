//
//  UIView+SPNIB.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SPNIB)

+ (UINib *)loadNib;
+ (UINib *)loadNibNamed:(NSString*)nibName;
+ (UINib *)loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;
+ (instancetype)loadInstanceFromNib;
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

@end
