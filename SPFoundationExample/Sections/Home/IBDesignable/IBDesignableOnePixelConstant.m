//
//  IBDesignableOnePixelConstant.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/22.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "IBDesignableOnePixelConstant.h"

IB_DESIGNABLE

@implementation IBDesignableOnePixelConstant

- (void)setOnePixelConstant:(NSInteger)onePixelConstant
{
    _onePixelConstant = onePixelConstant;
    self.constant = onePixelConstant * 1.0 / [UIScreen mainScreen].scale;
}

@end
