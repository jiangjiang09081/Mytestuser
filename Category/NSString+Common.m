//
//  NSString+Common.m
//  mobileOa
//
//  Created by sdy on 15-3-16.
//  Copyright (c) 2015年 sdy. All rights reserved.
//

#import "NSString+Common.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import <Availability.h>
#import <objc/runtime.h>

@implementation NSString (Common)

- (NSString *)monetizationString {
    return [NSString stringWithFormat:@"¥%@",self];
}

- (CGSize)sizeWithWidth:(CGFloat)width WithFont:(CGFloat)fontSize {
    //富文本设置文字行间距
    CGFloat lineSpacing = 2;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, NSParagraphStyleAttributeName, paragraphStyle, nil];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self attributes:attribute];
    NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithString:@"A" attributes:attribute];
    
    CGSize boundSize = CGSizeMake(width, 10000);
    CGSize size = [attributedString boundingRectWithSize:boundSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine context:nil].size;
    CGSize size1 = [attributedString1 boundingRectWithSize:boundSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine context:nil].size;
    
    CGFloat newWidth = roundf(size.width);
    CGFloat newHeight = roundf(size.height);
    int distance = size.height/size1.height;
    int distance2 = size.height - (size1.height * distance);
    
    if (size.width > newWidth) {
        newWidth += 1;
    }
    if (size.height > newHeight) {
        newHeight += 1;
    }
    if (distance2 > 0) {
        distance += 1;
    }
    newHeight += (distance - 1)*lineSpacing;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    return newSize;
}

- (id)jsonObject {
    if ([self length] > 0) {
        NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(@"jsonObjectError", @"NSString+Common", nil)};
        NSError *error = [[NSError alloc] initWithDomain:@"jsonObject" code:100 userInfo:userInfo];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        return jsonObject;
    }
    return nil;
}

- (NSString *)URLDecoded {
    NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                              (CFStringRef)self,
                                                                                                              CFSTR(""),
                                                                                                              kCFStringEncodingUTF8));
    return result;
}

- (NSString *)URLEncode {
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"),kCFStringEncodingUTF8));
}


@end

@implementation NSNull (Common)

- (NSUInteger)length {
    return 0;
}

- (NSUInteger)count {
    return 0;
}

@end
