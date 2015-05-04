//
//  NSData+extend.h
//  NSObject+extend
//
//  Created by Steven on 14/12/5.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSData_extend)

/**
 *  gzip压缩
 *
 *  @return 压缩后的数据
 */
- (NSData*)gzipCompression;

/**
 *  gzip解压
 *
 *  @return 解压后的数据
 */
- (NSData*)gzipDecompression;

/**
 *  tea加密
 *
 *  @param pwdkey 密码，大小为4的数组
 *
 *  @return 加密后的数据
 */
-(NSData*)addTEA:(const unsigned int *)pwdkey;

/**
 *  tea解密
 *
 *  @param pwdkey 密码，大小为4的数组
 *
 *  @return 解密后的数据
 */
-(NSData*)subtractTEA:(const unsigned int *)pwdkey;

/**
 *  把字节数组转为16进制字符串
 *
 *  @return 转换后的字符串
 */
-(NSString*)charToString;

/**
 *  把16进制字符串转换为字节数组
 *
 *  @return 转换后的字符串
 */
-(NSData*)StringTochar;

/**
 *  Base64字符串解码, “=”字符是可选的填充。空白符被忽略。
 *
 *  @param string 需要解码的Base64字符串
 *
 *  @return 返回已经解码的数据，失败返回nil
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

/**
 *  将数据流编码为Base64字符串
 *
 *  @return 返回Base64字符串，失败返回nil
 */
- (NSString *)base64Encoding;

@end
