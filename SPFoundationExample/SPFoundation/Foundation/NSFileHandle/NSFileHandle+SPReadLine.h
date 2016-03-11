//
//  NSFileHandle+SPReadLine.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileHandle (SPReadLine)

//theDelimier-分隔符
- (NSData *)readLineWithDelimiter:(NSString *)theDelimier;

@end
