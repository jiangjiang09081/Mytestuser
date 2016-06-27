//
//  BLBarButtonItem.h
//  Alimei-iPhone
//
//  Created by 61 on 2/15/14.
//  Copyright (c) 2014 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLBarButtonItem : UIBarButtonItem

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
             target:(id)target
             action:(SEL)action;

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
             target:(id)target
             action:(SEL)action
           withLeft:(BOOL)isleft;

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
              style:(UIBarButtonItemStyle)style
             target:(id)target
             action:(SEL)action;

- (id)initWithButtonView:(NSString *)title
                  target:(id)target
                  action:(SEL)action;

- (id)initWithButtonView:(NSString *)title
                  target:(id)target
                  action:(SEL)action
                withLeft:(BOOL)isLeft;

- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action;

- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action
           withLeft:(BOOL)isLeft;

- (void)setImage:(UIImage *)image;

@end
