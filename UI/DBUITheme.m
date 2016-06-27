//
//  DBUITheme.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBUITheme.h"

@implementation DBUITheme
- (void)loadTheme {
    // 程序基本字体颜色
    _colorProjectTextColor = HEXCOLOR(0x24292f); // 黑色
    _colorPinkTextColor = HEXCOLOR(0xde2253); // 粉红
    _colorDarkPinkTextColor = HEXCOLOR(0xe4143c); // 深粉红
    
    _colorProjectMainColor = HEXRGBCOLOR(0X52ADA9);
    _colorProjectGrayTextColor = HEXRGBCOLOR(0X6D6B6B);
    _colorProjectRedLineColor = HEXRGBCOLOR(0XDC3526);
    _colorProjectGrayLineColor = HEXRGBCOLOR(0X959596);
}
@end
