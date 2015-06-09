//
//  UITextView+extend.m
//  NSObject+extend
//
//  Created by Steven on 14/12/18.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import "UITextView+extend.h"

@implementation UITextView (UITextView_extend) 

- (void)setPlaceholder:(NSString *)placeholder {
    
    UILabel * label = (UILabel *)[self viewWithTag:(NSInteger)self];
    
    if (label == nil) {

        label = [[UILabel alloc] init];
        label.tag = (NSInteger)self;
        label.enabled = NO;
        label.font = self.font;
        label.textColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [label sizeToFit];
        
        [self addSubview:label];
        
        // 添加布局
        NSMutableArray *tmpConstraints = [NSMutableArray array];
        [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-7-[label]-7-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[label]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        [self addConstraints:tmpConstraints];
        
    }
    label.text = placeholder;
    label.hidden = self.text.length;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
    
}

- (NSString *)placeholder {
    UILabel * label = (UILabel *)[self viewWithTag:(NSInteger)self];
    return label.text;
}

- (void)textDidChange:(NSNotification *)notification {
    UILabel * label = (UILabel *)[self viewWithTag:(NSInteger)self];
    if (label) {
        label.hidden = self.text.length;
    }
}


@end
