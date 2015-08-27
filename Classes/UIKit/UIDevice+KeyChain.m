//
//  UIDevice+KeyChain.m
//  Pods
//
//  Created by Steven on 15/8/26.
//
//

#import "UIDevice+KeyChain.h"
#import <Security/Security.h>

@implementation UIDevice (UIDevice_KeyChain)


+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}

/**
 *  保存数据到KeyChain
 *
 *  @param key      数据标识符key
 *  @param object   需要保存的对象
 */
+ (void)saveKey:(NSString *)key object:(id)object;
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:key];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:(__bridge id)kSecValueData];
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

/**
 *  删除KeyChain中的数据
 *
 *  @param key      数据标识符key
 */
+ (void)deleteObjectWithKey:(NSString *)key;
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:key];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

/**
 *  获取KeyChain中的数据
 *
 *  @param key      数据标识符key
 */
+ (id)getObjectWithKey:(NSString *)key;
{
    id object = nil;
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:key];
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr)
    {
        @try
        {
            object = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *e)
        {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        }
        @finally
        {
            
        }
    }
    if (keyData)
        CFRelease(keyData);
    return object;
}

/**
 *  从KeyChain中读取设备的UDID，如果没有，先创建保存，然后返回
 *
 *  @return UDID
 */
+ (NSString *)UDID;
{
    static NSString * UDID_key = @"com.NSObjectExtent.KeyChain.udid";
    NSString * udid = [self getObjectWithKey:UDID_key];
    if ( !([udid isKindOfClass:NSString.class] && udid.length > 0) )
    {
        udid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [self saveKey:UDID_key object:udid];
    }
    return udid;
}

@end
