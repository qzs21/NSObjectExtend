//
//  UIImage+Stretchable.h
//  NSObject+extend
//
//  Created by Steven on 15/2/13.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 图像拉伸
@interface UIImage( UIImage_Stretchable )

/**
 *  生成一个中心拉伸的图片
 *
 *  @param name 图片资源名字
 *
 *  @return UIImage
 */
+ (instancetype)imageStretchableCenterNamed:(NSString *)name;

/// 基于self，生成一个中心拉伸的图片
- (UIImage *)imageStretchableCenter;

@end


@interface UIImageView ( UIImageView_Stretchable )

/// 拉伸图片中心
- (void)stretchableImageCenter;

@end


@interface UIButton ( UIButton_Stretchable )

/// 中心拉伸所有状态下BackgroundImage
- (void)stretchableBackgroundImageCenter;

/// 中心拉伸指定状态下BackgroundImage
- (void)stretchableBackgroundImageCenterForState:(UIControlState)state;

@end