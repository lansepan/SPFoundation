//
//  NSString+LocalizedString.m
//  SPFoundationExample
//
//  Created by BluePan on 16/8/23.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "NSString+LocalizedString.h"

@implementation NSString (LocalizedString)

- (NSLocale *)currentLocale
{
    NSString *localization = [NSBundle mainBundle].preferredLocalizations.firstObject;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localization];
    return locale;
}

- (NSString *)localizedString {
    return NSLocalizedString(self, nil);
}

- (NSString *)localizedStringFromTable:(NSString *)table {
    return NSLocalizedStringFromTable(self, table, nil);
}

- (NSString *)uppercaseLocalizedString {
    return [self uppercaseStringWithLocale:[self currentLocale]];
}

- (NSString *)lowercaseLocalizedString {
    return [self lowercaseStringWithLocale:[self currentLocale]];
}

- (NSString *)capitalizedLocalizedString {
    return [self capitalizedStringWithLocale:[self currentLocale]];
}

@end
