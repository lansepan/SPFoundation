//
//  NSString+LocalizedString.h
//  SPFoundationExample
//
//  Created by BluePan on 16/8/23.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LocalizedString)

- (NSString *)localizedString;

- (NSString *)localizedStringFromTable:(NSString *)table;

- (NSString *)uppercaseLocalizedString;

- (NSString *)lowercaseLocalizedString;

- (NSString *)capitalizedLocalizedString;

@end
