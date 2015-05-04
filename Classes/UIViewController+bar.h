//
//  UIViewController+bar.h
//  Pods
//
//  Created by Steven on 15/5/1.
//
//

#import <UIKit/UIKit.h>

/// 扩展导航栏按钮设置
@interface UIViewController (UIViewController_bar)

/**
 *  设置导航栏上的View
 *
 *  @param view UIView
 */
- (void)setRightView:(UIView *)view;
- (void)setLeftView:(UIView *)view;

/**
 *  创建并设置导航按钮
 *
 *  @param title  标题
 *  @param action 点击事件
 *
 *  @return 创建的UIButton
 */
- (UIButton *)createAndSetRightButtonWithTitle:(NSString *)title touchUpInsideAction:(SEL)action;
- (UIButton *)createAndSetLeftButtonWithTitle:(NSString *)title touchUpInsideAction:(SEL)action;

/**
 *  创建并设置导航按钮
 *
 *  @param normalImage      默认图片
 *  @param highlightedImage 高亮图片
 *  @param action           点击事件
 *
 *  @return 创建的UIButton
 */
- (UIButton *)createAndSetRightButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage touchUpInsideAction:(SEL)action;
- (UIButton *)createAndSetLeftButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage touchUpInsideAction:(SEL)action;

@end
