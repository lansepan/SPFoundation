//
//  MKMapView+SPBetterMaps.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapView (SPBetterMaps)

- (void)zoomToFitAnnotationsAnimated:(BOOL)animated;

@end
