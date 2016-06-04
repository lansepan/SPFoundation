//
//  IB_UITextField.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/22.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "IB_UITextField.h"

IB_DESIGNABLE

@implementation IB_UITextField

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius  = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, _Padding, _Padding);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

@end
