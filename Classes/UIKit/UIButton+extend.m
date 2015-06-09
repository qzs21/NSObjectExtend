//
//  UIButton+extend.m
//  NSObject+extend
//
//  Created by Steven on 14/12/15.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import "UIButton+extend.h"
#import "UIImage+extend.h"

@implementation UIButton (UIButton_extend)

- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    UIImage *pressedColorImg = [UIImage imageWithColor:color];
    [self setBackgroundImage:pressedColorImg forState:state];
}

- (void)setUnderlineWithColor:(UIColor *)color forState:(UIControlState)state {
    NSString * str = self.title;
    
    color = color ? color : [self titleColorForState:state];
    if (state != UIControlStateNormal && color == [self titleColorForState:UIControlStateNormal]) {
        color = [UIColor lightGrayColor];
    }
    
    NSDictionary * config = @{NSForegroundColorAttributeName: color,
                              NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    [AttributedStr addAttributes:config range:NSMakeRange(0, str.length)];
    [self setAttributedTitle:AttributedStr forState:state];
}

/**
 *  创建UIButton,根据标题大小自动设置frame.size
 *
 *  @param title  标题
 *  @param target 回调对象
 *  @param action 点击事件
 *
 *  @return UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target touchUpInsideAction:(SEL)action;
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGSize size = CGSizeZero;
    
    if (title.length)
    {
        UIFont * font = [UIFont systemFontOfSize:14];
        size = [title sizeWithFont:font];
        size = CGSizeMake(size.width + 15, size.height + 15);
        
        button.titleLabel.font = font;
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
    }
    
    [button setFrame:CGRectMake(0, 0, size.width, size.height)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/**
 *  创建UIButton,根据normalImage大小自动设置frame.size
 *
 *  @param normalImage      默认图片
 *  @param highlightedImage 高亮图片
 *  @param target           回调对象
 *  @param action           点击事件
 *
 *  @return UIButton
 */
+ (UIButton *)buttonWithNormalImage:(UIImage *)normalImage
                   highlightedImage:(UIImage *)highlightedImage
                             target:(id)target
                touchUpInsideAction:(SEL)action;
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGSize size = CGSizeZero;
    
    if (normalImage)
    {
        size = CGSizeMake( normalImage.size.width , normalImage.size.height );
        [button setImage:normalImage forState:UIControlStateNormal];
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    [button setFrame:CGRectMake(0, 0, size.width, size.height)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
