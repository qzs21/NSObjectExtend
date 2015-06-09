//
//  UIImage+Stretchable.m
//  NSObject+extend
//
//  Created by Steven on 15/2/13.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "UIImage+Stretchable.h"

@implementation UIImage ( UIImage_Stretchable )

+ (instancetype)imageStretchableCenterNamed:(NSString *)name {
    return [[UIImage imageNamed:name] imageStretchableCenter];
}

/// 基于self，生成一个中心拉伸的图片
- (UIImage *)imageStretchableCenter {
    return [self stretchableImageWithLeftCapWidth:(NSInteger)(self.size.width / 2.0) topCapHeight:(NSInteger)(self.size.height / 2.0)];
}

@end


@implementation UIImageView ( UIImageView_Stretchable )

- (void)stretchableImageCenter {
    self.image = self.image.imageStretchableCenter;
}

@end

@implementation UIButton ( UIButton_Stretchable )

/// 中心拉伸所有状态下BackgroundImage
- (void)stretchableBackgroundImageCenter {
    [self stretchableBackgroundImageCenterForState:UIControlStateNormal];
    [self stretchableBackgroundImageCenterForState:UIControlStateDisabled];
    [self stretchableBackgroundImageCenterForState:UIControlStateHighlighted];
    [self stretchableBackgroundImageCenterForState:UIControlStateSelected];
}

/// 中心拉伸指定状态下BackgroundImage
- (void)stretchableBackgroundImageCenterForState:(UIControlState)state {
    UIImage * image = [self backgroundImageForState:state];
    if (image) {
        [self setBackgroundImage:image.imageStretchableCenter forState:state];
    }
}

@end