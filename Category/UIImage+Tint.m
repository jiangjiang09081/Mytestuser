//
//  UIImage+Tint.m
//  BLiOSFramework
//
//  Created by 61 on 14-6-10.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (CGRect)getImageFrameWithFrame:(CGRect)frame {
    CGRect imageFrame = CGRectZero;
    CGSize imageSize = self.size;
    
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    CGFloat originX = 0;
    CGFloat originY = 0;
    
    if (imageWidth > imageHeight) {
        CGFloat scaleX = frame.size.width/imageWidth;
        imageWidth = imageWidth * scaleX;
        imageHeight = imageHeight * scaleX;
        if (frame.size.height < imageHeight) {
            CGFloat scaleY = frame.size.height/imageHeight;
            imageWidth = imageWidth * scaleY;
            imageHeight = imageHeight * scaleY;
        }
    }
    else {
        CGFloat scaleY = frame.size.height/imageHeight;
        imageWidth = imageWidth * scaleY;
        imageHeight = imageHeight * scaleY;
        if (imageWidth > frame.size.width) {
            CGFloat scaleX = frame.size.width/imageWidth;
            imageWidth = imageWidth * scaleX;
            imageHeight = imageHeight * scaleX;
        }
    }
    originX = frame.origin.x + (frame.size.width - imageWidth)/2;
    originY = frame.origin.y + (frame.size.height - imageHeight)/2;
    
    imageFrame = CGRectMake(originX, originY, imageWidth, imageHeight);
    return imageFrame;
}

@end
