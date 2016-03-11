//
//  UIButton+SPSubmitting.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SPSubmitting)

@property(nonatomic, readonly, getter=isSubmitting) NSNumber *submitting;

- (void)beginSubmitting:(NSString *)title;
- (void)endSubmitting;

@end
