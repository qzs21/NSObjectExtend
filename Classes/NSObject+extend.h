//
//  NSObject+extend.h
//  NSObject+extend
//
//  Created by Steven on 14/12/11.
//  Copyright (c) 2014年 Neva. All rights reserved.
//
//

#import "NSObjectDefine.h"
#import "NSData+extend.h"
#import "UIColor+extend.h"
#import "UIImage+extend.h"
#import "UIDevice+extend.h"
#import "UIView+extend.h"
#import "UIButton+extend.h"
#import "NSDate+extend.h"
#import "NSString+extend.h"
#import "UITextView+extend.h"
#import "NSNumber+extend.h"
#import "UINavigationController+extend.h"
#import "UITableViewCell+extend.h"
#import "UIImage+Stretchable.h"
#import "UILabelWithLine.h"
#import "UITextField+extend.h"
#import "NSException+extend.h"
#import "UIViewController+Nav.h"
#import "UIViewController+bar.h"

@interface NSObject (NSObject_extend)


/**
 *  扩展属性，用于保存必要的信息，基本类型请转成对象
 */
@property (nonatomic, strong) id userInfoExtend;

/**
 *  本地对象序列化成json字符串
 *
 *  @return json字符串
 */
- (NSString *)JSONString;

/**
 *  本地对象序列化成json数据流
 *
 *  @return json数据流
 */
- (NSData *)JSONData;

/**
 *  json格式的 NSData 或 NSString 解析成本地对象
 *
 *  @return 本地对象
 */
- (id)objectFromJSON;

/**
 *  获取程序编译时间
 *
 *  @return NSDate
 */
+ (NSDate *)buildDate;

/**
 *  检测测试包超时
 *
 *  *** 记得重新编译，避免编译缓存 ***
 *
 *  @param time           测试的时间长度（从编译日期开始）(单位s), 设置为0时可以永久使用
 *  @param timeoutTitle   超时后弹出UIAlertView的title
 *  @param timeoutMessage 超时后弹出UIAlertView的message
 *
 *  @return 测试包是否超时
 */
+ (BOOL)checkTestTime:(NSTimeInterval)time timeoutTitle:(NSString *)timeoutTitle timeoutMessage:(NSString *)timeoutMessage;


/**************** 
 
 只执行一次的扩展
 
 ****************/

/**
 *  在本对象的生命周期内，执行一次
 *
 *  @param block 执行的代码块
 */
- (void)do_once:(void(^)(void))block;

/**
 *  在对象生命周期内，使用key区分，如果key一样，只有以一个调用的位置会被执行
 *
 *  @param key   用于区分的key
 *  @param block 执行的代码块
 */
- (void)do_once_with_key:(NSString *)key block:(void(^)(void))block;

@end