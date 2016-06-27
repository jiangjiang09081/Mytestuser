//
//  DBUIImageView.m
//  DBShopping
//
//  Created by jiang on 16/4/22.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBUIImageView.h"

@interface DBUIImageView()

@property (nonatomic) id target;
@property (nonatomic) SEL selector;

@end


@implementation DBUIImageView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)addTarget:(id)target slecter:(SEL)selector{

    self.target = target;
    self.selector = selector;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if ([self.target respondsToSelector:self.selector] == YES) {
        [self.target performSelector:self.selector withObject:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
