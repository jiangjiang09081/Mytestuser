//
//  DBLoginModule.m
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBLoginModule.h"

#import "DBDataSettingViewController.h"
@implementation DBLoginModule

+ (DBLoginModule *)shareModule{
    static DBLoginModule *loginmodule = nil;
    if (!loginmodule) {
        
        loginmodule = [[DBLoginModule alloc]init];
    }
    return loginmodule;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
        
        NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
        if ([email length] > 0) {
            
            self.isUserLogin = YES;
        }
       
    }
    return self;
}

- (void)setIsUserLogin:(BOOL)isUserLogin{

//     NSLog(@"%@",(_isUserLogin?@"YES":@"NO"));
    
    _isUserLogin = isUserLogin;
    
    if (_isUserLogin) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UserLoginStatusChangeNotification object:nil];
    }
}

//登录

- (void)loginWithemail:(NSString *)email AndPassword:(NSString *)password finish:(void (^)(NSString *))finished{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:10];
    [parameter setObject:email forKey:@"email"];
    [parameter setObject:password forKey:@"pwd"];
    
    NSString *url = [NSString stringWithFormat:@"Api/login/email/%@/pwd/%@",email,password];
    
    [self postWithUrl:url AndParameter:parameter finish:^(id responseObject, NSError *error) {
       
        if (!error) {
            
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject objectForKey:@"data"] objectForKey:@"token"] forKey:@"token"];
                
                NSString *message = [responseObject objectForKey:@"message"];
                
                if ([message isEqualToString:@"success"] == YES) {
                    
                    self.isUserLogin = YES;
                    
                    _HTSET.minModule.token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
                }
                finished (message);
                
            }else{
            
                finished (dataNetWorkError);
            }
            
        }else{
        
            finished (defaultNetWorkError);
        }
        
    }];
    
}



- (void)loginOutFinish:(void (^)(BOOL loginOutSuccess))finished{
    [_HTSET.minModule getPersionalInfoFinish:^(id responseObject, NSError *error) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            self.isUserLogin = NO;
            
            NSString *token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"pwd"];
            _HTSET.minModule.token = token;
            _HTSET.minModule.email = @"";
            
            _HTUI.shoppingCartNVC.tabBarItem.badgeValue = @"0";
            
            finished (YES);
        }
        else {
            
            self.isUserLogin = YES;
            finished (NO);
        }
        
    }];
}

- (void)finish:(void (^)(id, NSError *))finished{
    [self postWithUrl:@"Api/user/create_user" AndParameter:nil finish:^(id responseObject, NSError *error) {
        finished (responseObject, error);
    }];
}
@end
