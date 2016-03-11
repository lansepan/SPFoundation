//
//  NSObject+SPKVO.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^KVOBlock)(NSDictionary *change, void *context);

@interface NSObject (SPKVO)

- (void)addObserver:(NSObject *)observer
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(void *)context
          withBlock:(KVOBlock)block;

- (void)removeBlockObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath;

- (void)addObserverForKeyPath:(NSString *)keyPath
                     options:(NSKeyValueObservingOptions)options
                     context:(void *)context
                   withBlock:(KVOBlock)block;

- (void)removeBlockObserverForKeyPath:(NSString *)keyPath;

@end
