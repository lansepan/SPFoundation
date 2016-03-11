//
//  MKMapView+SPMoveLogo.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (SPMoveLogo)

- (void)moveLogoByOffset:(CGPoint)offset;
- (void)moveLogoToPoint:(CGPoint)point;
- (UIView *)logo;

@end
