//
//  NSData+SPGZIP.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/2.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "NSData+SPGZIP.h"
#import <zlib.h>

#define CHUNK_SIZE 16384

@implementation NSData (SPGZIP)

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
- (NSData *)gzippedDataWithCompressionLevel:(float)level
{
    if ([self length])
    {
        z_stream stream;
        stream.zalloc = Z_NULL;
        stream.zfree = Z_NULL;
        stream.opaque = Z_NULL;
        stream.avail_in = (uint)[self length];
        stream.next_in = (Bytef *)[self bytes];
        stream.total_out = 0;
        stream.avail_out = 0;
        
        int compression = (level < 0.0f) ? Z_DEFAULT_COMPRESSION : (int)roundf(level * 9);
        
        if (deflateInit2(&stream, compression, Z_DEFLATED, 31, 8, Z_DEFAULT_STRATEGY) == Z_OK)
        {
            NSMutableData *data = [NSMutableData dataWithLength:CHUNK_SIZE];
            
            while (stream.avail_out == 0)
            {
                if (stream.total_out >= [data length])
                {
                    data.length += CHUNK_SIZE;
                }
                
                stream.next_out = [data mutableBytes] + stream.total_out;
                stream.avail_out = (uint)([data length] - stream.total_out);
                deflate(&stream, Z_FINISH);
            }
            
            deflateEnd(&stream);
            data.length = stream.total_out;
            return data;
        }
    }
    
    return nil;
}

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
- (NSData *)gzippedData
{
    return [self gzippedDataWithCompressionLevel:-1.0f];
}

/*!
 * @abstract
 * 使用gzip格式进行数据解压缩
 *
 * @result
 * 解压缩后的数据
 */
- (NSData *)gunzippedData
{
    if ([self length])
    {
        z_stream stream;
        stream.zalloc = Z_NULL;
        stream.zfree = Z_NULL;
        stream.avail_in = (uint)[self length];
        stream.next_in = (Bytef *)[self bytes];
        stream.total_out = 0;
        stream.avail_out = 0;
        
        NSMutableData *data = [NSMutableData dataWithLength:[self length] * 1.5];
        
        if (inflateInit2(&stream, 47) == Z_OK)
        {
            int status = Z_OK;
            
            while (status == Z_OK)
            {
                if (stream.total_out >= [data length])
                {
                    data.length += [self length] * 0.5;
                }
                
                stream.next_out = [data mutableBytes] + stream.total_out;
                stream.avail_out = (uint)([data length] - stream.total_out);
                status = inflate(&stream, Z_SYNC_FLUSH);
            }
            
            if (inflateEnd(&stream) == Z_OK)
            {
                if (status == Z_STREAM_END)
                {
                    data.length = stream.total_out;
                    return data;
                }
            }
        }
    }
    
    return nil;
}

@end