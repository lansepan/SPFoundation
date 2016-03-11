//
//  SPBarButton.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "SPBarButton.h"
#import "UIView+SPFoundation.h"

@implementation SPBarButton

- (void)setHighlighted:(BOOL)highlighted
{
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.y = 5;
    self.imageView.width = 25;
    self.imageView.height = 25;
    self.imageView.x = (self.width - self.imageView.width)/2.0;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.x = self.imageView.x - (self.titleLabel.width - self.imageView.width)/2.0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 2;
    self.titleLabel.font = [UIFont fontWithName:@"HYQiHei" size:10];
    self.titleLabel.shadowColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
