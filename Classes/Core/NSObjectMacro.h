//
//  NSObjectDefine.h
//  NSObject+extend
//
//  Created by Steven on 15/4/7.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#ifndef NSObject_extend_NSObjectDefine_h
#define NSObject_extend_NSObjectDefine_h


/*宏构造单例代码*/
#define LX_GTMOBJECT_SINGLETON_BOILERPLATE_WITH_SHARED(_object_name_, _obj_shared_name_) \
static _object_name_ *_##_object_name_ = nil; \
+ (instancetype)_obj_shared_name_ { \
if (!_##_object_name_) { \
@synchronized(self) { \
if (!_##_object_name_) { \
_##_object_name_ = [[[self class] alloc] init]; \
} \
} \
} \
return _##_object_name_; \
} \
+ (id)allocWithZone:(NSZone *)zone { \
@synchronized(self) { \
if (_##_object_name_ == nil) { \
_##_object_name_ = [super allocWithZone:zone]; \
return _##_object_name_; \
} \
} \
return nil; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return self; \
}

/*宏构造单例代码*/
#define LX_GTMOBJECT_SINGLETON_BOILERPLATE(_object_name_) LX_GTMOBJECT_SINGLETON_BOILERPLATE_WITH_SHARED(_object_name_, shared)


/**
 *  属性的Get方法，确保对象不为空，延迟初始化
 *
 *  @param property 属性名
 *  @param type     属性类型
 */
#define PROPERTY_GET_METHOD(property, type) \
- (type *)property \
{ \
if (_##property == nil) { \
_##property = [[type alloc] init]; \
} \
return _##property; \
}



/**
 *  获取屏幕宽度、高度、中心点
 */
#define getWindowWidth()     [[UIScreen mainScreen] bounds].size.width
#define getWindowHeight()    [[UIScreen mainScreen] bounds].size.height
#define getWindowCenter()    CGPointMake(getWindowWidth()/2.0, getWindowHeight/2.0)


#endif
