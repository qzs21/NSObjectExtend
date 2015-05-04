//
//  NSData+extend.m
//  NSObject+extend
//
//  Created by Steven on 14/12/5.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import "NSData+extend.h"
#include <zlib.h>


//位移
#define OFFSET 0

//加密解密轮数
#define TIMES 32

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";//设置编码


@implementation NSData (NSData_extend)

//gzip压缩
- (NSData*)gzipCompression
{
    if ([self length] == 0) return self;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in=(Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) return nil;
    
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];  // 16K chunks for expansion
    
    do {
        
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy: 16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
        
    } while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength: strm.total_out];
    return [NSData dataWithData:compressed];
}

//gzip解压
- (NSData*)gzipDecompression
{
    if ([self length] == 0) return self;
    
    unsigned full_length = (unsigned)[self length];
    unsigned half_length = (unsigned)([self length] / 2);
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
    while (!done)
    {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy: half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd (&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done)
    {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    }
    else return nil;
}

//tea加密
-(NSData*)addTEA:(const unsigned int *)pwdkey
{
    unsigned char * ch = (unsigned char*)[self bytes];
    int n = 8-self.length%8;
    char byte[self.length+n];
    char cc = n;
    for (int i=0; i<n; i++) {
        if (i==0) {
            byte[i] = cc;
        }
        else{
            byte[i] = 0;
        }
    }
    for (int i=0; i<self.length; i++) {
        byte[n+i] = ch[i];
    }
    
    int delta = 0x9e3779b9;
    int a     = pwdkey[0];
    int b     = pwdkey[1];
    int c     = pwdkey[2];
    int d     = pwdkey[3];
    
    unsigned char newbyte[self.length+n];
    for (int offset=0; offset<self.length+n; offset += 8) {
        int y = [self ByteTounint:byte[offset+3]] | [self ByteTounint:byte[offset+2]]<<8 | [self ByteTounint:byte[offset+1]]<<16 | [self ByteTounint:byte[offset+0]]<<24;
        int z = [self ByteTounint:byte[offset+7]] | [self ByteTounint:byte[offset+6]]<<8 | [self ByteTounint:byte[offset+5]]<<16 | [self ByteTounint:byte[offset+4]]<<24;
        int sum = 0;
        for (int i=0; i<TIMES; i++) {
            sum += delta;
            y += ((z<<4) + a) ^ (z + sum) ^ ((z>>5) + b);
            z += ((y<<4) + c) ^ (y + sum) ^ ((y>>5) + d);
        }
        newbyte[offset+7] = z & 0x000000ff;
        newbyte[offset+6] = (z & 0x0000ff00) >> 8;
        newbyte[offset+5] = (z & 0x00ff0000) >> 16;
        newbyte[offset+4] = (z & 0xff000000) >> 24;
        newbyte[offset+3] = y & 0x000000ff;
        newbyte[offset+2] = (y & 0x0000ff00) >> 8;
        newbyte[offset+1] = (y & 0x00ff0000) >> 16;
        newbyte[offset+0] = (y & 0xff000000) >> 24;
    }
    
    NSData * resultData = [NSData dataWithBytes:newbyte length:self.length+n];
    return resultData;
}

//tea解密
-(NSData*)subtractTEA:(const unsigned int *)pwdkey
{
    unsigned char * byte = (unsigned char*)[self bytes];
    int delta = 0x9e3779b9;
    int a     = pwdkey[0];
    int b     = pwdkey[1];
    int c     = pwdkey[2];
    int d     = pwdkey[3];
    unsigned char newbyte[self.length];
    for (int offset=0; offset<self.length; offset += 8) {
        int y = [self ByteTounint:byte[offset+3]] | [self ByteTounint:byte[offset+2]]<<8 | [self ByteTounint:byte[offset+1]]<<16 | [self ByteTounint:byte[offset+0]]<<24;
        int z = [self ByteTounint:byte[offset+7]] | [self ByteTounint:byte[offset+6]]<<8 | [self ByteTounint:byte[offset+5]]<<16 | [self ByteTounint:byte[offset+4]]<<24;
        int sum = 0;
        if (TIMES == 32) {
            sum = 0xC6EF3720;
        }
        else if (TIMES == 16){
            sum = 0xE3779B90;
        }
        else{
            sum = delta * TIMES;
        }
        
        for (int i=0; i<TIMES; i++) {
            z   -= ((y<<4) + c) ^ (y + sum) ^ ((y>>5) + d);
            y   -= ((z<<4) + a) ^ (z + sum) ^ ((z>>5) + b);
            sum -= delta;
        }
        newbyte[offset+7] = z & 0x000000ff;
        newbyte[offset+6] = (z & 0x0000ff00) >> 8;
        newbyte[offset+5] = (z & 0x00ff0000) >> 16;
        newbyte[offset+4] = (z & 0xff000000) >> 24;
        newbyte[offset+3] = y & 0x000000ff;
        newbyte[offset+2] = (y & 0x0000ff00) >> 8;
        newbyte[offset+1] = (y & 0x00ff0000) >> 16;
        newbyte[offset+0] = (y & 0xff000000) >> 24;
    }
    int n = newbyte[0];
    unsigned char ch[self.length-n];
    for (int i=0; i<self.length-n; i++) {
        ch[i] = newbyte[i+n];
    }
    NSData * resultData = [NSData dataWithBytes:ch length:self.length-n];
    return resultData;
}


//把字节数组转为16进制字符串
-(NSString*)charToString
{
    unsigned char * c = (unsigned char *)[self bytes];
    NSMutableString * string = [[NSMutableString alloc]initWithCapacity:0];
    for (int k=0; k<self.length; k++) {
        int n = c[k];
        int i = n/16;
        int j = n%16;
        if (j<10) {
            if (i<10) {
                NSString * str = [[NSString alloc]initWithFormat:@"%d%d",i,j];
                [string appendString:str];
            }
            else{
                NSString * str = [[NSString alloc]initWithFormat:@"%c%d",('A'+(i-10)),j];
                [string appendString:str];
            }
        }
        else{
            if (i<10) {
                NSString * str = [[NSString alloc]initWithFormat:@"%d%c",i,('A'+(j-10))];
                [string appendString:str];
            }
            else{
                NSString * str = [[NSString alloc]initWithFormat:@"%c%c",('A'+(i-10)),('A'+(j-10))];
                [string appendString:str];
            }
        }
    }
    return [NSString stringWithString:string];
}

//把16进制字符串转换为字节数组
-(NSData*)StringTochar
{
    char * c = (char*)[self bytes];
    char newC[self.length/2];
    for (int i=0; i<self.length/2; i++) {
        int l = c[2*i];
        int r = c[2*i+1];
        if (l>='0' && l<='9') {
            l=(l-'0')*16;
        }
        else if(l>='A' && l<='F'){
            l=((l-'A')+10)*16;
        }
        if (r>='0' && r<='9') {
            r=r-'0';
        }
        else if(r>='A' && r<='F'){
            r=(r-'A')+10;
        }
        newC[i] = l+r ;
    }
    
    NSData * resultData = [NSData dataWithBytes:newC length:self.length/2];
    return resultData;
}


//若某字节为负数则需将其转成无符号正数
- (int)ByteTounint:(int)byte
{
    if (byte<0) {
        return (byte+256);
    }
    return byte;
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)string {
    
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (NSString *)base64Encoding;
{//调用base64的方法
    
    if ([self length] == 0)
        return @"";
    
    char *characters = malloc((([self length] + 2) / 3) * 4);
    
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [self length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [self length])
            buffer[bufferLength++] = ((char *)[self bytes])[i++];
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';	
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}


@end
