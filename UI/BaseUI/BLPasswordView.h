//
//  BLPasswordView.h
//  Aliedu-iPhone
//
//  Created by tangtai on 14-4-3.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLPasswordView : UIView

@property (readonly, strong, nonatomic) UITextField *passwordField;

- (id)initWithFrame:(CGRect)frame leftIconName:(NSString *)leftIconName placeholder:(NSString *)placeholder;

@end
