//
//  BLTabBarItem.m
//  Alimei-iPhone
//
//  Created by alibaba on 13-12-10.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "BLTabBarItem.h"

@implementation BLTabBarItem

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
{
    if (IS_IOS7_OR_HIGHER)
    {
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0)
        if (image)
        {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        if (selectedImage)
        {
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        BLTabBarItem *item = [super initWithTitle:NSLocalizedString(title, nil)
                                            image:image
                                    selectedImage:selectedImage];
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      HEXCOLOR(0x64697b), NSForegroundColorAttributeName,
                                      nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      HEXCOLOR(0x5f99e5), NSForegroundColorAttributeName,
                                      nil] forState:UIControlStateSelected];

        [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
        [item setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
        
        return item;
#endif
    }
    else {
        BLTabBarItem *item = [[BLTabBarItem alloc] initWithTitle:NSLocalizedString(title, nil)
                                                           image:image
                                                             tag:0];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
        [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
        [item setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
        
        return item;
    }
}

@end
