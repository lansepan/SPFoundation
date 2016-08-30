//
//  UIView+Dynamic.m
//  Camera360
//
//  Created by peter on 13-11-27.
//  Copyright (c) 2013年 Pinguo. All rights reserved.
//

#import "UIView+Dynamic.h"

@implementation UIView (Dynamic)

- (void)moveTo:(float)toX toY:(float)toY duration:(float)duration completion:(void (^)(BOOL finished))completion{
    float distanceY = self.frame.origin.y - toY;
    float distanceX = self.frame.origin.x - toX;
    [UIView animateWithDuration:duration animations:^{
        [self setCenter:CGPointMake(self.center.x - distanceX,
                                    self.center.y - distanceY)];
    } completion:^(BOOL finished) {
        if(completion)
            completion(YES);
    }];
}
- (void)dropTo:(float)to duration:(float)duration completion:(void (^)(BOOL finished))completion{
    float distance = self.frame.origin.y - to;
    float toCenter = self.center.y - distance;
    float animationDuration = duration / 7;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self setCenter:CGPointMake(self.center.x,
                                    toCenter)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animationDuration animations:^{
            [self setCenter:CGPointMake(self.center.x,
                                        toCenter + distance / 2)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:animationDuration animations:^{
                [self setCenter:CGPointMake(self.center.x,
                                            toCenter)];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:animationDuration animations:^{
                    [self setCenter:CGPointMake(self.center.x,
                                                toCenter + distance / 4)];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:animationDuration animations:^{
                        [self setCenter:CGPointMake(self.center.x,
                                                    toCenter)];
                    }completion:^(BOOL finished) {
                        [UIView animateWithDuration:animationDuration animations:^{
                            [self setCenter:CGPointMake(self.center.x,
                                                        toCenter + distance / 8)];
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:animationDuration animations:^{
                                [self setCenter:CGPointMake(self.center.x,
                                                            toCenter)];
                            }completion:^(BOOL finished) {
                                if(completion)
                                    completion(YES);
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];
}

- (void)shootTo:(float)to duration:(float)duration completion:(void (^)(BOOL finished))completion{
    float distance = self.frame.origin.x - to;
    float toCenter = self.center.x - distance;
    float animationDuration = duration / 7;    
    [UIView animateWithDuration:animationDuration animations:^{
        [self setCenter:CGPointMake(toCenter,
                                    self.center.y)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animationDuration animations:^{
            [self setCenter:CGPointMake(toCenter + distance / 2,
                                        self.center.y)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:animationDuration animations:^{
                [self setCenter:CGPointMake(toCenter,
                                            self.center.y)];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:animationDuration animations:^{
                    [self setCenter:CGPointMake(toCenter + distance / 4,
                                                self.center.y)];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:animationDuration animations:^{
                        [self setCenter:CGPointMake(toCenter,
                                                    self.center.y)];
                    }completion:^(BOOL finished) {
                        [UIView animateWithDuration:animationDuration animations:^{
                            [self setCenter:CGPointMake(toCenter + distance / 8,
                                                        self.center.y)];
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:animationDuration animations:^{
                                [self setCenter:CGPointMake(toCenter,
                                                            self.center.y)];
                            }completion:^(BOOL finished) {
                                if(completion)
                                    completion(YES);
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];
}

- (void)recursiveEnumerateSubviewsUsingBlock:(void (^)(UIView *view, BOOL *stop))block {
	if (self.subviews.count == 0) {
		return;
	}
	for (UIView *subview in [self subviews]) {
		BOOL stop = NO;
		block(subview, &stop);
		if (stop) {
			return;
		}
		[subview recursiveEnumerateSubviewsUsingBlock:block];
	}
}

- (void)shake:(BOOL)enable{
    if (enable){
        CGFloat rotation = 0.03;
        
        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
        shake.duration = 0.13;
        shake.autoreverses = YES;
        shake.repeatCount  = MAXFLOAT;
        shake.removedOnCompletion = NO;
        shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
        shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
        
        [self.layer addAnimation:shake forKey:@"shakeAnimation"];
    }else{
        [self.layer removeAnimationForKey:@"shakeAnimation"];
    }
}
@end
