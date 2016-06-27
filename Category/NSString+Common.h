//
//  NSString+Common.h
//  mobileOa
//
//  Created by sdy on 15-3-16.
//  Copyright (c) 2015年 sdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Common)

/**
 *  获取带¥货币符号的字符串
 *
 *  @return 带¥货币符号的字符串
 */
- (NSString *)monetizationString;

/**
 *  获取字符串 在限定宽度和限定字体中的大小
 *
 *  @param width    限定宽度
 *  @param fontSize 字体大小
 *
 *  @return 大小
 */
- (CGSize)sizeWithWidth:(CGFloat)width WithFont:(CGFloat)fontSize;


/**
 *  将json格式的字符串 转成object
 * 
 *  @return object
 */
- (id)jsonObject;

- (NSString *)URLDecoded;

- (NSString *)URLEncode;

@end

@interface NSNull (Common)

- (NSUInteger)length;

- (NSUInteger)count;

@end

