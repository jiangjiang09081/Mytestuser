//
//  UIImage+Tint.h
//  BLiOSFramework
//
//  Created by 61 on 14-6-10.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

- (CGRect)getImageFrameWithFrame:(CGRect)frame;

@end
