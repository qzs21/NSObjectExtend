//
//  UIViewController+Nav.m
//  iAuto360
//
//  Created by Steven on 15/1/21.
//  Copyright (c) 2015年 YaMei. All rights reserved.
//

#import "UIViewController+Nav.h"
#import <objc/runtime.h>
#import "UIDevice+extend.h"

static const char* ParamKey                             = "ParamKey";
static const char* ParentVCKey                          = "ParentVCKey";


@implementation UIViewController (UIViewController_Nav)

- (void)setParam:(id)param
{
    objc_setAssociatedObject(self, ParamKey, param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)param
{
    return (id)objc_getAssociatedObject(self,ParamKey);
}

- (void)setParentVC:(UIViewController *)parentVC
{
    objc_setAssociatedObject(self, ParentVCKey, parentVC, OBJC_ASSOCIATION_ASSIGN);
}
- (UIViewController *)parentVC
{
    return (id)objc_getAssociatedObject(self,ParentVCKey);
}


/// Storyboard中获取ViewonController
+ (UIViewController *)getViewControllerFromStoryboard:(NSString *)storyboardName key:(NSString *)key
{
    UIStoryboard * story = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [story instantiateViewControllerWithIdentifier:key];
}

/// 通过字符串类名查找ViewController
- (UIViewController *)getControllerWithKey:(NSString *)key
{
    UIViewController * viewController = nil;
    for (UIViewController * vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:NSClassFromString(key)])
        {
            viewController = vc;
            break;
        }
    }
    return viewController;
}



/**
 *  push storyboard 的初始化界面
 *
 *  @param storyBoardName storyBoard 名字
 *  @param param          界面传参
 *  @param animated       是否动画
 *
 *  @return 已经初始化对控制器
 */
- (id)pushInstantiateIntiaViewController:(NSString *)storyBoardName
                                   param:(id)param
                                animated:(BOOL)animated
{
    UIStoryboard * story = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController * vc = [story instantiateInitialViewController];
    return [self pushViewController:vc param:param animated:animated];
}
/**
 *  push storyboard 的初始化界面, 开启动画
 *
 *  @param storyBoardName storyBoard 名字
 *  @param param          界面传参
 *
 *  @return 已经初始化对控制器
 */
- (id)pushInstantiateIntiaViewController:(NSString *)storyBoardName
                                   param:(id)param
{
    return [self pushInstantiateIntiaViewController:storyBoardName param:param animated:YES];
}

/**
 *  push viewController
 *
 *  @param viewController viewController
 *  @param param          界面传参
 *  @param animated       是否动画
 *
 *  @return 已经初始化对控制器
 */
- (id)pushViewController:(UIViewController *)viewController
                   param:(id)param
                animated:(BOOL)animated
{
    viewController.param = param;
    viewController.parentVC = (id)self;
    
#if DEBUG_MODE
    NSAssert([viewController isKindOfClass:UIViewController.class], @"实现 <BaseViewControllerInterface> 的类必须是UIViewController或其子类!");
#endif
    
    UINavigationControllerAnimated type = animated ? UINavigationControllerAnimatedPush : UINavigationControllerAnimatedNone;
    
    // iOS6会直接Push，这里延时Push控制器，解决参数传递问题
    if ([UIDevice iOSVersion] >= 7.0)
    {
        [self.navigationController push:viewController animated:type];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController push:viewController animated:type];
        });
    }
    
    return viewController;
}



/**
 *  push viewController
 *
 *  @param storyboardKey     storyboard的名字
 *  @param viewControllerKey viewController 在 storyboard 中的 key
 *  @param param             界面传参
 *  @param animated          是否动画
 *
 *  @return 已经初始化对控制器
 */
- (id)pushStoryboardKey:(NSString *)storyboardKey
      viewControllerKey:(NSString *)viewControllerKey
                  param:(id)param
               animated:(BOOL)animated
{
    UIViewController * vc = [self.class getViewControllerFromStoryboard:storyboardKey key:viewControllerKey];
    return [self pushViewController:vc param:param animated:animated];
}

- (id)pushStoryboardKey:(NSString *)storyboardKey
      viewControllerKey:(NSString *)viewControllerKey
                  param:(id)param
{
    return [self pushStoryboardKey:storyboardKey viewControllerKey:viewControllerKey param:param animated:YES];
}


/**
 *  push viewController
 *
 *  @param viewControllerKey viewController 在 storyboard 中的 key
 *  @param param             界面传参
 *  @param animated          是否动画
 *
 *  @return 已经初始化对控制器
 */
- (id)pushViewControllerKey:(NSString *)viewControllerKey
                      param:(id)param
                   animated:(BOOL)animated
{
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerKey];
    return [self pushViewController:vc param:param animated:animated];
}

/**
 *  push viewController , 开启动画
 *
 *  @param viewControllerKey viewController 在 storyboard 中的 key
 *  @param param             界面传参
 *
 *  @return 已经初始化对控制器
 */
- (id)pushViewControllerKey:(NSString *)viewControllerKey
                      param:(id)param
{
    return [self pushViewControllerKey:viewControllerKey param:param animated:YES];
}




/**
 *  present viewController ( 模态推出 )
 *
 *  @param stroyboardKey     storyboard的名字
 *  @param viewControllerKey viewController 在 storyboard 中的 key
 *  @param param             界面传参
 *  @param animated          是否动画
 *
 *  @return 已经初始化对控制器
 */
- (id)presentStoryboardKey:(NSString *)storyboardKey
         viewControllerKey:(NSString *)viewControllerKey
                     param:(id)param
{
    UIViewController * vc = [self.class getViewControllerFromStoryboard:storyboardKey key:viewControllerKey];
    vc.parentVC = self;
    vc.param = param;
    [self.navigationController push:vc animated:UINavigationControllerAnimatedModal];
    return vc;
}



- (id)replaceViewControllerKey:(NSString *)viewControllerKey
                 toStoryboardKey:(NSString *)toStoryboardKey
             toViewControllerKey:(NSString *)toViewControllerKey
                           param:(id)param
                        animated:(UINavigationControllerAnimated)animated
{
    UIViewController * fromViewcController = [self getControllerWithKey:viewControllerKey];
    if (fromViewcController)
    {
        UIViewController * toViewController = [self.class getViewControllerFromStoryboard:toStoryboardKey key:toViewControllerKey];
        [self.navigationController replaceViewControllerAnimated:animated formViewController:fromViewcController toViewController:toViewController, nil];
        return toViewController;
    }
    else
    {
        NSLog(@"找不到指定类名的控制器 : %@", viewControllerKey);
        return nil;
    }
}

- (id)replaceToStoryboardKey:(NSString *)toStoryboardKey
           toViewControllerKey:(NSString *)toViewControllerKey
                         param:(id)param
                      animated:(UINavigationControllerAnimated)animated
{
    UIViewController * toViewController = [self.class getViewControllerFromStoryboard:toStoryboardKey key:toViewControllerKey];
    toViewController.param = param;
    [self.navigationController replaceViewControllerAnimated:animated formViewController:self toViewController:toViewController, nil];
    return toViewController;
}

- (id)replaceAllToStorayboardKey:(NSString *)toStoryboardKey
               toViewControllerKey:(NSString *)toViewControllerKey
                             param:(id)param
                          animated:(UINavigationControllerAnimated)animated
{
    UIViewController * toViewController = [self.class getViewControllerFromStoryboard:toStoryboardKey key:toViewControllerKey];
    toViewController.param = param;
    [self.navigationController replaceAllToViewControllerAnimated:animated toViewController:toViewController, nil];
    return toViewController;
}

/// 动画过渡，替换underViewController之上的控制器, 通过key索引
- (id)replaceUnderViewControllerKey:(NSString *)underViewControllerKey
                      toStoryboardKey:(NSString *)toStoryboardKey
               toViewControllerKey:(NSString *)toViewControllerKey
                             param:(id)param
                          animated:(UINavigationControllerAnimated)animated
{
    UIViewController * underViewController = [self getControllerWithKey:underViewControllerKey];
    
    if (underViewController)
    {
        UIViewController * toViewController = [self.class getViewControllerFromStoryboard:toStoryboardKey key:toViewControllerKey];

        NSUInteger index = [self.navigationController.viewControllers indexOfObject:underViewController];
        if (index < self.navigationController.viewControllers.count - 1)
        {
            UIViewController * formViewController = self.navigationController.viewControllers[index +1];
            [self.navigationController replaceViewControllerAnimated:animated formViewController:formViewController toViewController:toViewController, nil];
        }
        else
        {
            [self.navigationController push:toViewController animated:animated];
            
        }
        return toViewController;
    }
    else
    {
        NSLog(@"找不到指定类名的控制器 : %@", underViewController);
        return nil;
    }
}


@end
