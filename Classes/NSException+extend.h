//
//  NSException+extend.h
//  NSObject+extend
//
//  Created by Steven on 15/4/24.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^UncatchExceptionHandlerBlock) (NSString *info);

@interface NSException (NSException_extend)

/// 异常日志信息, 用于记录日志
@property (nonatomic, readonly) NSString * logString;

/**
 *  启动异常捕获，回调未处理的日志。回调时机：1.崩溃信息产生时 2.启动异常捕获时，如果存在未处理的日志，将会回调
 *  @param block 异常日志会被逐个回调，开发者需要对日志进行处理(如上传服务器)，回调代码块运行在子线程，如果成功处理，返回YES，异常日志将会被标记为已处理
 */
+ (void)startUncatchExceptionWithHandlerBlock:(UncatchExceptionHandlerBlock)block;

@end
