//
//  DBUITheme.h
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUITheme : NSObject

- (void)loadTheme;

// 程序基本字体颜色
@property (strong, nonatomic) UIColor *colorProjectTextColor; // 黑色
@property (strong, nonatomic) UIColor *colorPinkTextColor; // 粉红
@property (strong, nonatomic) UIColor *colorDarkPinkTextColor; // 深粉红

//主色和字体颜色
@property (nonatomic, strong) UIColor *colorProjectMainColor;
@property (nonatomic, strong) UIColor *colorProjectGrayTextColor;
@property (nonatomic, strong) UIColor *colorProjectRedLineColor;
@property (nonatomic, strong) UIColor *colorProjectGrayLineColor;

@end
