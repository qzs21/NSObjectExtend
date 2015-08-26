//
//  UIDevice+KeyChain.h
//  Pods
//
//  Created by Steven on 15/8/26.
//
//

#import <UIKit/UIKit.h>

@interface UIDevice (UIDevice_KeyChain)

/**
 *  保存数据到KeyChain
 *
 *  @param key      数据标识符key
 *  @param object   需要保存的对象
 */
+ (void)saveKey:(NSString *)key object:(id)object;

/**
 *  删除KeyChain中的数据
 *
 *  @param key      数据标识符key
 */
+ (void)deleteObjectWithKey:(NSString *)key;


/**
 *  获取KeyChain中的数据
 *
 *  @param key      数据标识符key
 *  @return         object
 */
+ (id)getObjectWithKey:(NSString *)key;

/**
 *  从KeyChain中读取设备的UDID，如果没有，先创建保存，然后返回
 *
 *  @return UDID
 */
+ (NSString *)UDID;

@end
