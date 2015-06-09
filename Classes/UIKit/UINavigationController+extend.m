//
//  UINavigationController+extend.m
//  NSObject+extend
//
//  Created by Steven on 15/1/21.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "UINavigationController+extend.h"
#import <objc/runtime.h>


static const char* PushTypeKey = "PushTypeKey";
static const char* willToBeViewControllerItemsKey       = "willToBeViewControllerItemsKey";

@interface UIViewController ( UIViewController_PopType ) <UINavigationControllerDelegate>
@property (nonatomic, assign) UINavigationControllerAnimated pushType;
@property (nonatomic, strong) NSArray * willToBeViewControllerItems;
@end

@implementation UIViewController (UIViewController_PopType)

- (void)setPushType:(UINavigationControllerAnimated)pushType { objc_setAssociatedObject(self, PushTypeKey, @(pushType), OBJC_ASSOCIATION_ASSIGN); }
- (UINavigationControllerAnimated)pushType { return [(id)objc_getAssociatedObject(self,PushTypeKey) integerValue]; }

- (void)setWillToBeViewControllerItems:(NSArray *)willToBeViewControllerItems { objc_setAssociatedObject(self, willToBeViewControllerItemsKey, willToBeViewControllerItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
- (NSArray *)willToBeViewControllerItems { return (id)objc_getAssociatedObject(self,willToBeViewControllerItemsKey); }

@end



@implementation UINavigationController ( UINavigationController_extend )

/// 添加底部push动画
- (void)addBottomPushAnimated {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3 * [[UIScreen mainScreen] bounds].size.height / [[UIScreen mainScreen] bounds].size.width;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
}
/// 添加底部pop动画
- (void)addBottomPopAnimated {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3 * [[UIScreen mainScreen] bounds].size.height / [[UIScreen mainScreen] bounds].size.width;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
}


- (void)push:(UIViewController *)viewController animated:(UINavigationControllerAnimated)animated {
    
    viewController.pushType = animated;
    
    switch (animated) {
        case UINavigationControllerAnimatedNone:
            [self pushViewController:viewController animated:NO];
            break;
        case UINavigationControllerAnimatedPush:
            [self pushViewController:viewController animated:YES];
            break;
        case UINavigationControllerAnimatedModal:
            [self addBottomPushAnimated];
            [self pushViewController:viewController animated:NO];
            break;
        default:
            break;
    }
}
- (void)pushAnimated:(UINavigationControllerAnimated)animated viewControllers:(UIViewController *)viewControllers, ... NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray * viewControllersItems = [NSMutableArray arrayWithObject:viewControllers];
    va_list list;
    va_start( list, viewControllers );
    while (YES) {
        UIViewController * vc = va_arg( list, UIViewController * );
        if (!vc) { break; }
        [viewControllersItems addObject:vc];
    }
    va_end( list );
    
    for (UIViewController * vc in viewControllersItems) { vc.pushType = animated; }
    
    NSMutableArray * items = [NSMutableArray arrayWithArray:self.viewControllers];
    [items addObjectsFromArray:viewControllersItems];
    [items.lastObject setWillToBeViewControllerItems:items];
    self.delegate = self;
    [self push:items.lastObject animated:animated];
}


- (void)popAnimated:(UINavigationControllerAnimated)animated {

    switch (animated) {
        case UINavigationControllerAnimatedNone:
            [self popViewControllerAnimated:NO];
            break;
        case UINavigationControllerAnimatedPush:
            [self popViewControllerAnimated:YES];
            break;
        case UINavigationControllerAnimatedModal:
            [self addBottomPopAnimated];
            [self popViewControllerAnimated:NO];
            break;
        default:
            break;
    }
}
- (void)popAnimated {
    [self popAnimated:self.topViewController.pushType];
}

- (void)popTo:(UIViewController *)viewController animated:(UINavigationControllerAnimated)animated {
    switch (animated) {
        case UINavigationControllerAnimatedNone:
            [self popToViewController:viewController animated:NO];
            break;
        case UINavigationControllerAnimatedPush:
            [self popToViewController:viewController animated:YES];
            break;
        case UINavigationControllerAnimatedModal:
            [self addBottomPopAnimated];
            [self popToViewController:viewController animated:NO];
            break;
        default:
            break;
    }
}
- (void)popTo:(UIViewController *)viewController {
    [self popTo:viewController animated:self.topViewController.pushType];
}

#pragma mark - 动画过渡，替换栈内控制器

/// 动画过渡，替换栈内所有控制器 到 viewController
- (void)replaceAllToViewControllerAnimated:(UINavigationControllerAnimated)animated toViewController:(UIViewController *)toViewControllers , ... NS_REQUIRES_NIL_TERMINATION {
    
    NSMutableArray * viewControllersItems = [NSMutableArray arrayWithObject:toViewControllers];
    va_list list;
    va_start( list, toViewControllers );
    while (YES) {
        //返回可变参数，va_arg第二个参数为可变参数类型，如果有多个可变参数，依次调用可获取各个参数
        UIViewController * vc = va_arg( list, UIViewController * );
        if (!vc) { break; }
        [viewControllersItems addObject:vc];
    }
    va_end( list );
    
    [self replaceViewControllerAnimated:animated formViewController:self.viewControllers.firstObject toViewControllers:viewControllersItems];
}

/// 动画过渡，替换栈内控制器 formViewController 到 toViewController
- (void)replaceViewControllerAnimated:(UINavigationControllerAnimated)animated formViewController:(UIViewController *)formViewController toViewController:(UIViewController *)toViewControllers , ... NS_REQUIRES_NIL_TERMINATION {

    NSMutableArray * viewControllersItems = [NSMutableArray arrayWithObject:toViewControllers];
    va_list list;
    va_start( list, toViewControllers );
    while (YES) {
        //返回可变参数，va_arg第二个参数为可变参数类型，如果有多个可变参数，依次调用可获取各个参数
        UIViewController * vc = va_arg( list, UIViewController * );
        if (!vc) { break; }
        [viewControllersItems addObject:vc];
    }
    va_end( list );
    
    [self replaceViewControllerAnimated:animated formViewController:formViewController toViewControllers:viewControllersItems];
}

- (void)replaceViewControllerAnimated:(UINavigationControllerAnimated)animated formViewController:(UIViewController *)formViewController toViewControllers:(NSArray *)toViewControllers {
    NSArray * array = self.viewControllers;
    NSInteger toIndex = [array indexOfObject:formViewController];
    
    if (toIndex == NSNotFound) { NSLog(@"找不到指定控制器 : %@", formViewController); return; }
    
    NSMutableArray * willBeItems = [NSMutableArray arrayWithArray:[array subarrayWithRange:NSMakeRange(0, toIndex)]];
    [willBeItems addObjectsFromArray:toViewControllers];
    
    self.delegate = self;
    [toViewControllers.lastObject setWillToBeViewControllerItems:willBeItems];
    
    [self push:toViewControllers.lastObject animated:animated];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.willToBeViewControllerItems.count) {
        navigationController.viewControllers = viewController.willToBeViewControllerItems;
        navigationController.delegate = nil;
        viewController.willToBeViewControllerItems = nil;
    }
}

@end
