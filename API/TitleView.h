//
//  TitleView.h
//  TitleScrollView
//
//  Created by 任前辈 on 16/1/6.
//  Copyright © 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleView;//前置声明 告诉编译器有这个类 别报错

@protocol TitleViewDelegate <NSObject>

/**
 *  代理方法
 *
 *  @param view  当titleview点击了 对应的button之后会被调用
 *  @param index 选中的位置
 */
-(void)titleView:(TitleView *)view selectIndex:(NSInteger)index;


@end


@interface TitleView : UIView

@property(nonatomic,strong)NSArray * titles;

@property(nonatomic,strong)NSMutableArray * buttons;

@property(nonatomic,weak)id<TitleViewDelegate>delegate;

/**
 *  设置选中第几个button
 *
 *  @param index 选中的位置
 */
-(void)selectIndex:(NSInteger)index;

//有动画 会调用代理方法

-(void)clickButton:(UIButton*)button;

@end
