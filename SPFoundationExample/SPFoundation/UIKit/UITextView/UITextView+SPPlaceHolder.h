//
//  UITextView+SPPlaceHolder.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (SPPlaceHolder) <UITextViewDelegate>

@property (nonatomic, strong) UITextView *placeHolderTextView;

- (void)addPlaceHolder:(NSString *)placeHolder;

@end
