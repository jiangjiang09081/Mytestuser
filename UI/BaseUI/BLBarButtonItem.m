//
//  BLBarButtonItem.m
//  Alimei-iPhone
//
//  Created by 61 on 2/15/14.
//  Copyright (c) 2014 Alibaba. All rights reserved.
//

#import "BLBarButtonItem.h"

@implementation BLBarButtonItem

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
             target:(id)target
             action:(SEL)action {
    return [self initWithImage:image
              highlightedImage:highlightedImage
                        target:target
                        action:action
                      withLeft:YES];
}

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
             target:(id)target
             action:(SEL)action
           withLeft:(BOOL)isleft
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 46, 44)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.opaque = NO;
    
    CGFloat leftInset = floorf((23 - image.size.width/2) + 5);
    
    if (isleft) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -leftInset, 0, leftInset)];
    }
    else {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, leftInset, 0, -leftInset)];
    }
    
    
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    if (highlightedImage) {
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    self = [super initWithCustomView:button];
    
    return self;
}

+ (UIButton *)buttonViewWithColor:(UIColor *)normalColor
                 highlightedColor:(UIColor *)highlightedColor
                     disableColor:(UIColor *)disableColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 68, 44)];
    if (normalColor)
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    if (highlightedColor)
        [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    if (disableColor)
        [button setTitleColor:disableColor forState:UIControlStateDisabled];
    
    return button;
}

- (id)initWithButtonViewWithColor:(UIColor *)normalColor
                 highlightedColor:(UIColor *)highlightedColor
                     disableColor:(UIColor *)disableColor
                            title:(NSString *)title
                           target:(id)target
                           action:(SEL)action
                         withLeft:(BOOL)isLeft {
    UIButton *button = [BLBarButtonItem buttonViewWithColor:normalColor
                                           highlightedColor:highlightedColor
                                               disableColor:disableColor];
    
    CGSize size = [title sizeWithWidth:300 WithFont:16];
    CGFloat width = size.width + 10 + 20;
    if (width <= 68) {
        width = 68;
    }
    [button setFrame:CGRectMake(0, 0, width, 44)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    self = [super initWithCustomView:button];
    if (isLeft) {
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    }
    else {
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
    }
    
    return self;
}

- (id)initWithButtonView:(NSString *)title
                  target:(id)target
                  action:(SEL)action
                withLeft:(BOOL)isLeft {
    return [self initWithTitle:title target:target action:action withLeft:isLeft];
}

- (id)initWithButtonView:(NSString *)title
                  target:(id)target
                  action:(SEL)action {
    return [self initWithButtonView:title target:target action:action withLeft:YES];
}

- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action
           withLeft:(BOOL)isLeft {
    return  [self initWithButtonViewWithColor:[UIColor blackColor]
                             highlightedColor:[UIColor blackColor]
                                 disableColor:[UIColor grayColor]
                                        title:title
                                       target:target
                                       action:action
                                     withLeft:isLeft];
}

- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action {
    return [self initWithTitle:title target:target action:action withLeft:YES];
}

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
              style:(UIBarButtonItemStyle)style
             target:(id)target
             action:(SEL)action
{
    if (IS_IOS7_OR_HIGHER) {
        self = [super initWithImage:image style:style target:target action:action];
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        if (image) {
            [button setImage:image forState:UIControlStateNormal];
        }
        
        if (highlightedImage) {
            [button setImage:highlightedImage forState:UIControlStateHighlighted];
        } else {
            UIImage *highlightImage = [image imageWithTintColor:HEXCOLOR(0xfad5d2)];
            [button setImage:highlightImage
                    forState:UIControlStateHighlighted];
        }
        
        self = [super initWithCustomView:button];
    }

    return self;
}

- (void)setImage:(UIImage *)image
{
    if (IS_IOS7_OR_HIGHER) {
        [super setImage:image];
    } else {
        if ([self.customView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)self.customView;
            UIImage *highlightImage = [image imageWithTintColor:HEXCOLOR(0xfad5d2)];
            [btn setImage:image forState:UIControlStateNormal];
            [btn setImage:highlightImage forState:UIControlStateHighlighted];
        } else {
            [super setImage:image];
        }
    }
}

@end
