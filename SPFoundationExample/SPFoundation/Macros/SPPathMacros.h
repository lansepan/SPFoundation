//
//  PathMacros.h
//  JingYaSiTing
//
//  Created by BluePan on 16/2/26.
//  Copyright © 2016年 中联苹果实验室. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PATH_TEMP NSTemporaryDirectory()

#define PATH_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) objectAtIndex:0]

#define PATH_CACHE [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface SPPathMacros : NSObject

@end


