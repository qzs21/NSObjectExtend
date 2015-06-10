//
//  UIView+extend.m
//  NSObject+extend
//
//  Created by Steven on 14/12/10.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import "UIView+extend.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (UIView_extend)

- (void)setFilletRadius:(CGFloat)filletRadius
{
    self.layer.cornerRadius = filletRadius;
    self.clipsToBounds = YES;
}

- (CGFloat)filletRadius {
    return self.layer.cornerRadius;
}

-(void)clearAllSubView{
    for (UIView * subView in [self subviews]) {
        if ([[subView subviews] count] > 0) {
            for (UIView * s in [subView subviews]) {
                [s clearAllSubView];
            }
        }
        [subView removeFromSuperview];
    }
}
-(NSArray *)allSubViews {
    NSMutableArray * items = [NSMutableArray array];
    for (UIView * v in [self subviews]) {
        [items addObject:v];
        if ([[v subviews] count] > 0) {
            [items addObjectsFromArray:[v allSubViews]];
        }
    }
    return [NSArray arrayWithArray:items];
}

-(void)resignResponder {
    if ([self isKindOfClass:[UITextField class]]) {
        [(UITextField *)self resignFirstResponder];
    }
    if ([self isKindOfClass:[UITextView class]]) {
        [(UITextView *)self resignFirstResponder];
    }
    if ([[self subviews] count] > 0) {
        for (UIView * v in [self subviews]) {
            [v resignResponder];
        }
    }
}

- (UIImage *)imageSnapshot
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.bounds.size.width, self.bounds.size.height), NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    return viewImage;
}

-(void)setHeight:(CGFloat)height {
    CGRect rect = [self frame];
    rect.size.height = height;
    [self setFrame:rect];
}
-(CGFloat)height {
    return self.frame.size.height;
}
-(void)setWidth:(CGFloat)width {
    CGRect rect = [self frame];
    rect.size.width = width;
    [self setFrame:rect];
}
-(CGFloat)width {
    return self.frame.size.width;
}
-(void)setX:(CGFloat)x {
    CGRect rect = [self frame];
    rect.origin.x = x;
    [self setFrame:rect];
}
-(CGFloat)X {
    return self.frame.origin.x;
}
-(void)setY:(CGFloat)y {
    CGRect rect = [self frame];
    rect.origin.y = y;
    [self setFrame:rect];
}
-(CGFloat)Y {
    return self.frame.origin.y;
}

- (CGFloat)viewHeightWithLimitWidth:(CGFloat)limitWidth
{
    self.bounds = CGRectMake(0.0f, 0.0f, limitWidth, CGRectGetHeight(self.bounds));
    
    [self layoutIfNeeded];
    
    for (UILabel * lab in self.allSubViews)
    {
        if ([lab isKindOfClass:UILabel.class])
        {
            lab.preferredMaxLayoutWidth = lab.bounds.size.width;
        }
    }
    
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}


@end
