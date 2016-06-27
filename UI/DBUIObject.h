//
//  DBUIObject.h
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUIObject : NSObject

@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) UITabBarController *tabBarVc;
@property (nonatomic,strong) UINavigationController *shoppingCartNVC;

- (void)showLoginView;

- (void)showMainWindow;

- (void)showTabBarVC;

@end
