//
//  BLPasswordView.m
//  Aliedu-iPhone
//
//  Created by tangtai on 14-4-3.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import "BLPasswordView.h"

@interface BLPasswordView () <UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *openPassImageView;

@end

@implementation BLPasswordView

- (id)initWithFrame:(CGRect)frame leftIconName:(NSString *)leftIconName placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        CGFloat letfEdge = 16.0f;
        CGFloat rightEdge = 10.0f;
        
        //    inputView.backgroundColor = [UIColor whiteColor];
        //    inputView.layer.cornerRadius = 5.0f;
        //    [inputView setClipsToBounds:YES];
        //    inputView.layer.borderWidth = 0.5;
        //    inputView.layer.borderColor = [UIColor grayColor].CGColor;
        
        /*
         左边图标
         */
        CGRect leftFrame = CGRectZero;
//        
//        UILabel *label = [[UILabel alloc] init];
//        label.font = [UIFont systemFontOfSize:14.0];
//        label.text = leftIconName;
//        CGSize z = [label.text sizeWithWidth:0 WithFont:label.font.pointSize];
//        label.frame = CGRectMake(10, 0, z.width, 40);
//        leftFrame = label.frame;
        
        if(leftIconName){
            CGFloat imageLeftPadding = 15.0f;
            letfEdge = 14.0f;
            UIImageView *leftIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftIconName]];
            leftIconView.tag = 1;
            leftIconView.center = CGPointMake(0, self.frame.size.height/2);
            leftFrame = leftIconView.frame;
            leftFrame.origin.x = imageLeftPadding;
            leftIconView.frame = leftFrame;
//            [self addSubview:label];
            [self addSubview:leftIconView];
        }
        
        CGRect rightFrame = CGRectZero;
        UIImageView *rightIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eye"]];
        rightIconView.userInteractionEnabled = YES;
        rightIconView.tag = 3;
        rightFrame = rightIconView.frame;
        rightFrame.origin.x = self.frame.size.width - rightEdge - rightIconView.frame.size.width;
        rightFrame.origin.y = 11.0f;
        rightIconView.frame = rightFrame;
        _openPassImageView = rightIconView;
        [self addSubview:rightIconView];

        /*
         中间textField
         */
        CGFloat deleteButtonMarginRight = 3.0f;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(leftFrame.origin.x + leftFrame.size.width + letfEdge, 10, self.frame.size.width - (leftFrame.origin.x + leftFrame.size.width + letfEdge+rightEdge - deleteButtonMarginRight + rightFrame.size.width), 30.0f)];
//        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20 + z.width + 10, 14, self.frame.size.width - 35 - z.width, 20.0f)];
        
        textField.tag = 2;
        textField.font = [UIFont systemFontOfSize:14.0f];
        textField.backgroundColor = [UIColor clearColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.placeholder = placeholder;
        textField.secureTextEntry = YES;
        textField.delegate = self;
        _passwordField = textField;
        [self addSubview:textField];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openPassTapped:)];
        [rightIconView addGestureRecognizer:tap];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) openPassTapped:(id)sender
{
    if (_passwordField.secureTextEntry) {
        _passwordField.secureTextEntry = NO;
        [_openPassImageView setImage:BLImage(@"eye－点击")];
    } else {
        _passwordField.secureTextEntry = YES;
        [_openPassImageView setImage:BLImage(@"eye")];
    }
    
    [_passwordField becomeFirstResponder];
}

@end
