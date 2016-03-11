//
//  MKMapView+SPMoveLogo.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "MKMapView+SPMoveLogo.h"

@implementation MKMapView (SPMoveLogo)

- (void)moveLogoByOffset:(CGPoint)offset {
    UIView* logo = [self logo];
    
    logo.frame = CGRectOffset(logo.frame, offset.x, offset.y);
}

- (void)moveLogoToPoint:(CGPoint)point {
    UIView* logo = [self logo];
    
    logo.frame = CGRectMake(point.x, point.y, logo.frame.size.width, logo.frame.size.height);
}

- (UIView*)logo {
    UIView* logo;
    
    //Google Maps
    for (UIView *subview in self.subviews) {
        if ([subview isMemberOfClass:[UIImageView class]]) {
            logo = (UIView*)subview;
            break;
        }
    }
    
    //If we're on Apple Maps, there is no UIImageView.
    if (!logo) {
        for (UIView *subview in self.subviews)
            if ([subview isKindOfClass:[UILabel class]]) {
                logo = (UIView*)subview;
                break;
            }
    }
    
    return logo;
}

@end
