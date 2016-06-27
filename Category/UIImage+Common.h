//
//  UIImageExt.h
//  MaskDemo
//
//  Created by 董继明 on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Common)

+ (UIImage*)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

- (UIImage*)imageByScalingForSize:(CGSize)targetSize;

- (UIImage*)imageByScalingForMaxWidth:(CGFloat)maxWidth;

- (UIImage *)colorized:(UIColor *)color;

- (UIImage *)imageByScalingForMaxWidth:(float)maxWidth
         scalingAndCroppingForMinWidth:(float)minWidth;

- (UIImage *)clipImageWithovalWidth:(float)ovalWidth ovalHeight:(float)ovalHeight;

- (UIImage *)imageForScreenScale;

- (UIImage *)fixOrientation;

@end
