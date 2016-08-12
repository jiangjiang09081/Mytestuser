//
//  DBUIObject.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBUIObject.h"
#import "CommodityViewController.h"
#import "CartViewController.h"
#import "IntegralViewController.h"
#import "MeViewController.h"
#import "BLTabBarItem.h"
#import "DBLoginViewController.h"
#import "DBFirstInViewController.h"
#import "DBShoppingCart.h"
@interface DBUIObject()<UITabBarControllerDelegate>

@end;

@implementation DBUIObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        _window.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)showMainWindow{
    NSString *firstIn = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstIn"];
    
    if (!firstIn || [firstIn length] == 0) {
        DBFirstInViewController *firstInfVC = [[DBFirstInViewController alloc]init];
        _window.rootViewController = firstInfVC;
    }
    else{
        
        if (!_HTSET.loginModule.isUserLogin) {
            
//          [_HTSET.loginModule finish:^(id responseObject, NSError *error) {
//              if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                  
//              }
            [self showLoginView];
//          }];
       }
        else{
        [self showTabBarVC];
        }
    }
    [_window makeKeyAndVisible];
}



- (void)showTabBarVC{
    if (!_tabBarVc) {
        [_tabBarVc removeFromParentViewController];
        UITabBarController *tabBarVC = [[UITabBarController alloc]init];
        tabBarVC.delegate = self;
        _tabBarVc = tabBarVC;
        
        UINavigationController *commodityNVC = [[UINavigationController alloc]initWithRootViewController:[[CommodityViewController alloc]init]];
        commodityNVC.tabBarItem = [[BLTabBarItem alloc]initWithTitle:@"Commodity" image:[UIImage imageNamed:@"3@2x"] selectedImage:[UIImage imageNamed:@"8@2x"]];
        
        UINavigationController *cartNVC = [[UINavigationController alloc]initWithRootViewController:[[CartViewController alloc]init]];
        cartNVC.tabBarItem = [[BLTabBarItem alloc]initWithTitle:@"Cart" image:[UIImage imageNamed:@"1@2x"] selectedImage:[UIImage imageNamed:@"6@2x"]];
        _shoppingCartNVC = cartNVC;
        
        UINavigationController *integralNVC = [[UINavigationController alloc]initWithRootViewController:[[IntegralViewController alloc]init]];
        integralNVC.tabBarItem = [[BLTabBarItem alloc]initWithTitle:@"Integral" image:[UIImage imageNamed:@"4@2x"] selectedImage:[UIImage imageNamed:@"9@2x"]];
        
        UINavigationController *meNVC = [[UINavigationController alloc]initWithRootViewController:[[MeViewController alloc]init]];
        meNVC.tabBarItem = [[BLTabBarItem alloc]initWithTitle:@"Me" image:[UIImage imageNamed:@"2@2x"] selectedImage:[UIImage imageNamed:@"7@2x"]];
        
        tabBarVC.viewControllers = @[commodityNVC,_shoppingCartNVC,meNVC];
        for (UITabBarItem *item in _tabBarVc.tabBar.items) {
            
            [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HEXRGBCOLOR(0x64697b),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
            
            [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HEXRGBCOLOR(0x1395F1),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        }
        
    }
  //判断用户登录后加载用户购物车的情况,用户未登录时加载购物车的数据
    if (_HTSET.loginModule.isUserLogin) {
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        DBShoppingCart *shoppingCart = [_HTSET.managerModule getShoppingCartGoods];
        
        int number = 0;
        for (NSDictionary *dic in [[[shoppingCart.goods objectForKey:@"userLogin"] objectForKey:str] objectForKey:@"loginsaveArray"]) {
            if (dic) {
                
                NSString *num = [dic objectForKey:@"number"];
                number += [num intValue];
                
                _shoppingCartNVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",number];
                
            }else{
                
                _shoppingCartNVC.tabBarItem.badgeValue = @"0";
            }

        }
        
        
    }else{
    
        DBShoppingCart *shoppingCart = [_HTSET.managerModule getShoppingCartGoods];
        int number = 0;
        
        for (NSDictionary *dic in [[shoppingCart.goods objectForKey:@"userNoLogin"] objectForKey:@"saveArr"]) {
                
            NSString *num = [dic objectForKey:@"number"];
            number += [num intValue];
            
        }
        _shoppingCartNVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",number];
    }
    
    _tabBarVc.selectedIndex = 0;
    _window.rootViewController = _tabBarVc;
    

}


- (void)showLoginView{

    DBLoginViewController *loginVC = [[DBLoginViewController alloc]init];
    UINavigationController *lodinNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    _window.rootViewController = lodinNC;
}



















@end
