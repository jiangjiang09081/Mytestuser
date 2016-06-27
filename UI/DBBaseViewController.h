//
//  DBBaseViewController.h
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBBaseViewController : UIViewController

@property (nonatomic, strong) UIBarButtonItem *rightBarButtontem;

- (void)showAlertViewWithMessage:(NSString *)message;

@end
