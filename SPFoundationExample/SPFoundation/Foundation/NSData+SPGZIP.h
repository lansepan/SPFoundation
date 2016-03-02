//
//  NSData+SPGZIP.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/2.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SPGZIP)

/*!
 * @abstract
 * 使用gzip格式进行数据压缩
 *
 * @param level
 * 压缩比，默认为Z_DEFAULT_COMPRESSION
 *
 * @result
 * 压缩后的数据
 */
- (NSData *)gzippedDataWithCompressionLevel:(float)level;

/*!
 * @abstract
 * 使用gzip格式进行数据压缩
 *
 * @discussion
 * 压缩比，默认为Z_DEFAULT_COMPRESSION
 *
 * @result
 * 压缩后的数据
 */
- (NSData *)gzippedData;

/*!
 * @abstract
 * 使用gzip格式进行数据解压缩
 *
 * @result
 * 解压缩后的数据
 */
- (NSData *)gunzippedData;

@end
