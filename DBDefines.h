//
//  DBDefines.h
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//
#import "AppDelegate.h"
#ifndef DBDefines_h
#define DBDefines_h

#define _APP    ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define _HTSET             _APP.setObject
#define _HTUI              _APP.uiObject
#define _HTTHEME           _APP.uiTheme

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define HEXCOLOR(hexValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]
#define HEXACOLOR(hexValue, alphaValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:(alphaValue)]
#define HEXRGBCOLOR(h)      RGBCOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF))
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define MainColor           _APP.uiTheme.colorProjectMainColor

#define BLImage(imageName)  [UIImage imageNamed:imageName]
#define BLString(key)       NSLocalizedString(key, key)
#define NONullString(key)       [key length] > 0 ? key : @""

#define MainHeight [UIScreen mainScreen].bounds.size.height
#define MainWidth [UIScreen mainScreen].bounds.size.width

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//不知道是否为string类型 转换成NSString类型
#define ISString(str)   [str isKindOfClass:[NSString class]]? str : [str stringValue];

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:243.0/255.0 green:248.0/255.0 blue:252.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
//#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//#define APIBaseURL        @"http://www.tanghushi.com/api/mobile/?version=2"
//#define GET_DEFAIL        @"getdefail"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// 设备
#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_5_OR_HIGHER         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 568.0f)
#define IS_IPHONE_6         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)

#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 是否是iOS 6或者更高版本
#define IS_IOS6_OR_HIGHER       SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")

// 是否是iOS 7或者更高版本
#define IS_IOS7_OR_HIGHER       SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

// 是否是iOS 8或者更高版本
#define IS_IOS8_OR_HIGHER       SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define UserLoginStatusChangeNotification @"kUserLoginStatusChange"



#endif /* DBDefines_h */
