//
//  DBChooseGoodinfo.m
//  DBShopping
//
//  Created by jiang on 16/4/21.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBChooseGoodinfo.h"

@implementation DBChooseGoodinfo

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    if (self) {
        UIButton *contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        contentButton.frame = self.bounds;
        contentButton.alpha = 0.0f;
        contentButton.backgroundColor = [UIColor blackColor];
        [contentButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _contentButton = contentButton;
        [self addSubview:_contentButton];
        
        UIView *choseBodyView = [[UIView alloc] initWithFrame:CGRectMake(0, MainHeight, MainWidth, 200)];
        choseBodyView.backgroundColor = [UIColor whiteColor];
        _choseBodyView = choseBodyView;
        _choseBodyView.userInteractionEnabled = YES;
        [self addSubview:_choseBodyView];
        
        [self showView];
    }
    return self;
}

- (void)showView{
    
    CGRect newFrame = CGRectMake(0, MainHeight - _choseBodyView.size.height, MainWidth, _choseBodyView.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        _contentButton.alpha = 0.5f;
        _choseBodyView.frame = newFrame;
    }];
}

- (void)dismiss{

    [UIView animateWithDuration:0.3 animations:^{
        
        _contentButton.alpha = 0.0f;
        _choseBodyView.frame = CGRectMake(0, MainHeight, MainWidth, _choseBodyView.size.height);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
