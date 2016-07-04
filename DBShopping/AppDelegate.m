//
//  AppDelegate.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "AppDelegate.h"
#import "DBLoginModule.h"
#import "WXApi.h"
#import "UMSocialSnsService.h"
#import "UMSocialData.h"
#import "UMSocialConfig.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
@interface AppDelegate ()<UIApplicationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  在info里面设置View controller-based status bar appearance = NO;白色 YES,黑色  则下面的不起作用
     */
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    /**
     *内存缓存 ->4M  磁盘缓存  ->20M  
     *disPath 如果是nil,会缓存到cached的bundleId目录下
     */
    
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:4*1024*1024 diskCapacity:20*1024*1024 diskPath:nil];
    [NSURLCache setSharedURLCache:cache];
    
    /**
     第三方登录
     */
    [WXApi registerApp:@"wx76f1fe821ac5c89e" withDescription:@"Wechat"];
    [UMSocialConfig setSnsPlatformNames:@[UMShareToSina]];
    
    _setObject = [[DBSettingObject alloc]init];
    
    //若用户已经存在,直接登录
    if (token && [token length] > 0) {
        
        [_setObject getCommonInformation:token];
        
      //若没有存在,分配新的用户
    }else{
        
        [_setObject getTokenInformation];
    }
    
    
    _uiObject = [[DBUIObject alloc]init];
    [_uiObject showMainWindow];
    
    _uiTheme = [[DBUITheme alloc]init];
    [_uiTheme loadTheme];
    
    // Override point for customization after application launch.
    return YES;
}

//微信返回第三方APP
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
        
        return [WXApi handleOpenURL:url delegate:(id)self];
  
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{


    return [WXApi handleOpenURL:url delegate:(id)self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
