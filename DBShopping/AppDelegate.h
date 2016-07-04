//
//  AppDelegate.h
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBSettingObject.h"
#import "DBUIObject.h"
#import "DBUITheme.h"
#import "MeViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) DBSettingObject *setObject;
@property (nonatomic, strong) DBUIObject *uiObject;
@property (nonatomic, strong) DBUITheme *uiTheme;
@property (nonatomic, strong) MeViewController *me;

@end

