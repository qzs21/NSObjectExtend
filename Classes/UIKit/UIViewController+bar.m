//
//  UIViewController+bar.m
//  Pods
//
//  Created by Steven on 15/5/1.
//
//

#import "UIViewController+bar.h"
#import "UIButton+extend.h"

@implementation UIViewController (UIViewController_bar)

- (void)setRightView:(UIView *)view
{
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)setLeftView:(UIView *)view
{
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = buttonItem;
}

/**
 *  创建并设置导航按钮
 *
 *  @param title  标题
 *  @param action 点击事件
 *
 *  @return 创建的UIButton
 */
- (UIButton *)createAndSetRightButtonWithTitle:(NSString *)title touchUpInsideAction:(SEL)action
{
    UIButton * button = [UIButton buttonWithTitle:title target:self touchUpInsideAction:action];
    [self setRightView:button];
    return button;
}
- (UIButton *)createAndSetLeftButtonWithTitle:(NSString *)title touchUpInsideAction:(SEL)action
{
    UIButton * button = [UIButton buttonWithTitle:title target:self touchUpInsideAction:action];
    [self setLeftView:button];
    return button;
}

/**
 *  创建并设置导航按钮
 *
 *  @param normalImage      默认图片
 *  @param highlightedImage 高亮图片
 *  @param action           点击事件
 *
 *  @return 创建的UIButton
 */
- (UIButton *)createAndSetRightButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage touchUpInsideAction:(SEL)action
{
    UIButton * button = [UIButton buttonWithNormalImage:normalImage highlightedImage:highlightedImage target:self touchUpInsideAction:action];
    [self setRightView:button];
    return button;
}
- (UIButton *)createAndSetLeftButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage touchUpInsideAction:(SEL)action
{
    UIButton * button = [UIButton buttonWithNormalImage:normalImage highlightedImage:highlightedImage target:self touchUpInsideAction:action];
    [self setLeftView:button];
    return button;
}


@end
