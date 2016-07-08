//
//  WelcomeView.h
//  SPFoundationExample
//
//  Created by BluePan on 16/7/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

//欢迎界面
#import <UIKit/UIKit.h>

@interface WelcomeView : UIView

@property (nonatomic, assign) BOOL hidePage;

- (void)setData:(NSArray *)imgs hidePage:(BOOL)hidePage
;

@end
