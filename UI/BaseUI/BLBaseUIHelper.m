//
//  BLBaseUIHelper.m
//  Alimei-iPhone
//
//  Created by chicp on 13-12-10.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "BLBaseUIHelper.h"
#import <QuartzCore/QuartzCore.h>

@implementation BLBaseUIHelper

+ (UIScrollView *)baseScorllViewWithFrame:(CGRect)frame{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    scrollView.autoresizesSubviews = YES;
    return scrollView;
}

+ (UITextField *)baseInputTextFieldWithFrame:(CGRect)frame{
    UITextField *textFiled = [[UITextField alloc] initWithFrame:frame];
    textFiled.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    return textFiled;
}

+ (UIButton *)baseButtonWithFrame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    button.frame = frame;
    return button;
}

+ (UIButton *)baseButtonWithNormalImageName:(NSString *)imageName hover:(NSString *)hoverImageName origin:(CGPoint)origin{
    UIImage *normal = [UIImage imageNamed:imageName];
    UIImage *hover = [UIImage imageNamed:hoverImageName];
    UIButton *button = [self baseButtonWithFrame:CGRectMake(origin.x, origin.y, normal.size.width, normal.size.height)];
    [button setBackgroundImage:normal forState:UIControlStateNormal];
    [button setBackgroundImage:hover forState:UIControlStateHighlighted];
    return button;
}

+ (UIView *)baseInputViewWithFrame:(CGRect)frame leftIcon:(NSString *)leftName rightIcon:(UIButton *)rightName placeholder:(NSString *)placeholder textFeildDelegate:(id<UITextFieldDelegate>)delegate{
    
    CGFloat letfEdge = 16.0f;
    CGFloat rightEdge = 10.0f;
    UIView *inputView = [[UIView alloc] initWithFrame:frame];
    inputView.backgroundColor = [UIColor whiteColor];
//    inputView.layer.cornerRadius = 5.0f;
    [inputView setClipsToBounds:YES];
//    inputView.layer.borderWidth = 0.5;
//    inputView.layer.borderColor = [UIColor grayColor].CGColor;
    
    /*
     左边图标
     */
    CGRect leftFrame = CGRectZero;
    if(leftName){
//        CGFloat imageLeftPadding = 15.0f;
//        letfEdge = 14.0f;
//        UIImageView *leftIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftName]];
//        leftIconView.tag = 1;
//        leftIconView.center = CGPointMake(0, inputView.frame.size.height/2);
//        leftFrame = leftIconView.frame;
//        leftFrame.origin.x = imageLeftPadding;
//        leftIconView.frame = leftFrame;
//        
//        [inputView addSubview:leftIconView];
        letfEdge = 0.0f;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, frame.size.height)];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = leftName;
        leftFrame = titleLabel.frame;
        titleLabel.textColor = HEXCOLOR(0x262626);
        [inputView addSubview:titleLabel];
    }
    
    /*
     右边图标
     */
    CGRect rightFrame = CGRectZero;
    if(rightName){
        UIButton *rightIconView = rightName;
        NSString *str = @"获取验证码";
        [rightIconView setTitle:str forState:UIControlStateNormal];
        rightIconView.backgroundColor = HEXRGBCOLOR(0XE21F57);
        rightIconView.titleLabel.font = [UIFont systemFontOfSize:12.0];
        rightIconView.layer.cornerRadius = 2.0;
        CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0], NSFontAttributeName, nil]];
        rightIconView.frame = CGRectMake(inputView.size.width - size.width - 10, 5, size.width, inputView.size.height - 10);
//        UIImageView *rightIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightName]];
//        rightIconView.userInteractionEnabled = YES;
        rightIconView.tag = 3;
        rightFrame = rightIconView.frame;
//        rightFrame.origin.x = inputView.frame.size.width - rightEdge - rightIconView.frame.size.width;
//        rightFrame.origin.y = 11.0f;
//        rightIconView.frame = rightFrame;
        [inputView addSubview:rightIconView];
    }
    /*
     中间textField
     */
    CGFloat deleteButtonMarginRight = 3.0f;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(leftFrame.origin.x + leftFrame.size.width + letfEdge, (frame.size.height - 20)/2, inputView.frame.size.width - 10 - (leftFrame.origin.x + leftFrame.size.width + letfEdge+rightEdge - deleteButtonMarginRight + rightFrame.size.width), 20.0f)];
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20 + z.width + 10, 14, inputView.frame.size.width - 35 - z.width, 20.0f)];
    textField.tag = 2;
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.backgroundColor = [UIColor clearColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.placeholder = placeholder;
    textField.delegate = delegate;
//    textField.textColor = [UIColor whiteColor];
    [inputView addSubview:textField];
//    [inputView.layer setBorderColor:HEXCOLOR(0xDDDDDD).CGColor];
//    [inputView.layer setMasksToBounds:YES];
//    [inputView.layer setBorderWidth:1.0];
    return inputView;
}

- (void)sendCode {
    
}

+ (UITextView *)baseTextView:(CGRect)frame{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.font = [UIFont systemFontOfSize:14];
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    return textView;
}

+ (UIBarButtonItem *)baseBarButtonItemWithNormalImage:(UIImage *)normalImage
                                        selectedImage:(UIImage *)selectedImage
                                               target:(id)target
                                               action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 24, 24);
    if (normalImage)
    {
        button.frameSize = normalImage.size;
    }
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UILabel *)baseLabelWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    
    return label;
}

+ (BLPasswordView *)basePasswordViewWithFrame:(CGRect)frame leftIcon:(NSString *)leftIcon placeholder:(NSString *)placeholder
{
    BLPasswordView *view = [[BLPasswordView alloc] initWithFrame:frame leftIconName:leftIcon placeholder:placeholder];
//    view.layer.borderColor = HEXCOLOR(0xDDDDDD).CGColor;
//    view.layer.borderWidth = 1.0;
    return view;
}

+ (UIButton *)baseLastStepButtonWithFrame:(CGRect)frame target:(id)target action:(SEL)action {
    UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upBtn.frame = frame;
    [upBtn setTitle:@"上一步" forState:UIControlStateNormal];
    upBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    upBtn.layer.cornerRadius = 20.0;
    upBtn.layer.borderColor = _APP.uiTheme.colorProjectMainColor.CGColor;
    [upBtn setTitleColor:MainColor forState:UIControlStateNormal];
    upBtn.layer.borderWidth = 1.0;
    [upBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return upBtn;
}

+ (UIButton *)baseNextStepButtonWithFrame:(CGRect)frame target:(id)target action:(SEL)action {
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = frame;
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    nextBtn.layer.cornerRadius = 20.0;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.backgroundColor = MainColor;
    [nextBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return nextBtn;
}

+ (UIView *)baseInputViewWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle placeholder:(NSString *)placeholder {
    UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 65, frame.size.height)];
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = leftTitle;
    titleLabel.textColor = HEXCOLOR(0x262626);
    [backgroundView addSubview:titleLabel];
    
    UITextField *inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, MainWidth-70-30, frame.size.height)];
    inputTextField.placeholder = placeholder;
    inputTextField.textColor = HEXCOLOR(0x262626);
    inputTextField.tag = 2;
    inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [backgroundView addSubview:inputTextField];
    
    return backgroundView;
}

@end
