//
//  BLBaseUIHelper.h
//  Alimei-iPhone
//
//  Created by chicp on 13-12-10.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLPasswordView.h"

@interface BLBaseUIHelper : NSObject

+ (UIScrollView *)baseScorllViewWithFrame:(CGRect)frame;

+ (UITextField *)baseInputTextFieldWithFrame:(CGRect)frame;

+ (UIButton *)baseButtonWithFrame:(CGRect)frame;

+ (UIButton *)baseButtonWithNormalImageName:(NSString *)imageName hover:(NSString *)hoverImageName origin:(CGPoint)origin;

+ (UIView *)baseInputViewWithFrame:(CGRect)frame leftIcon:(NSString *)leftName rightIcon:(UIButton *)rightName placeholder:(NSString *)placeholder textFeildDelegate:(id<UITextFieldDelegate>)delegate;

+ (UITextView *)baseTextView:(CGRect)frame;

+ (UIBarButtonItem *)baseBarButtonItemWithNormalImage:(UIImage *)normalImage
                                        selectedImage:(UIImage *)selectedImage
                                               target:(id)target
                                               action:(SEL)action;

+ (UILabel *)baseLabelWithFrame:(CGRect)frame andTitle:(NSString *)title;

+ (BLPasswordView *)basePasswordViewWithFrame:(CGRect)frame leftIcon:(NSString *)leftIcon placeholder:(NSString *)placeholder;

+ (UIButton *)baseLastStepButtonWithFrame:(CGRect)frame
                                   target:(id)target
                                   action:(SEL)action;

+ (UIButton *)baseNextStepButtonWithFrame:(CGRect)frame
                                   target:(id)target
                                   action:(SEL)action;

+ (UIView *)baseInputViewWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle placeholder:(NSString *)placeholder;

@end
