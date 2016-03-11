//
//  SPTextVerticalButton.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "SPTextVerticalButton.h"
#import "UIView+SPFoundation.h"

@implementation SPTextVerticalButton

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height+self.spacing;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
