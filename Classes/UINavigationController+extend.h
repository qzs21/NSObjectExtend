//
//  UINavigationController+extend.h
//  NSObject+extend
//
//  Created by Steven on 15/1/21.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, UINavigationControllerAnimated) {
    UINavigationControllerAnimatedNone      = -1,       // 无动画
    UINavigationControllerAnimatedPush      = 0,        // push
    UINavigationControllerAnimatedModal     = 1,        // 模态弹出
};


/// 扩展 UINavigationController, 实现push时动画选择，实现替换堆栈中的 UIViewController
@interface  UINavigationController ( UINavigationController_extend )

/// push 推出UIViewController, 并选择动画
- (void)push:(UIViewController *)viewController animated:(UINavigationControllerAnimated)animated;
/// push 一组UIViewController
- (void)pushAnimated:(UINavigationControllerAnimated)animated viewControllers:(UIViewController *)viewControllers, ... NS_REQUIRES_NIL_TERMINATION;


/// pop 控制器，指定动画类型
- (void)popAnimated:(UINavigationControllerAnimated)animated;
/// pop 控制器，自动判断动画类型
- (void)popAnimated;
/// pop 到指定UIViewController, 指定动画类型
- (void)popTo:(UIViewController *)viewController animated:(UINavigationControllerAnimated)animated;
/// pop 到指定UIViewController 自动选择动画类型
- (void)popTo:(UIViewController *)viewController;


/// 动画过渡，替换栈内所有控制器 到 viewControllers
- (void)replaceAllToViewControllerAnimated:(UINavigationControllerAnimated)animated toViewController:(UIViewController *)toViewControllers , ... NS_REQUIRES_NIL_TERMINATION;

/// 动画过渡，替换栈内控制器 formViewController 到 toViewControllers
- (void)replaceViewControllerAnimated:(UINavigationControllerAnimated)animated formViewController:(UIViewController *)formViewController toViewController:(UIViewController *)toViewControllers , ... NS_REQUIRES_NIL_TERMINATION;


@end
