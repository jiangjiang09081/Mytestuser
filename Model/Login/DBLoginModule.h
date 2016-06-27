//
//  DBLoginModule.h
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBBaseModule.h"
#define DefaultNetWork

@interface DBLoginModule : DBBaseModule

@property (nonatomic, assign) BOOL isUserLogin;
@property (nonatomic, assign) BOOL userChanged;
@property (nonatomic, assign) BOOL userShoppingChanged;
@property (nonatomic, assign) BOOL createOrderSuccess;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *token_secret;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSDictionary *userData;
@property (nonatomic, strong) NSDictionary *shoppingCartGoodDic;
//数据 整个程序通用
@property (nonatomic, strong) NSArray *addressList;
+ (DBLoginModule *)shareModule;

//登录
- (void)loginWithemail:(NSString *)email
                 AndPassword:(NSString *)password
                      finish:(void (^)(NSString *message))finished;
//退出登录
- (void)loginOutFinish:(void (^)(BOOL loginOutSuccess))finished;


- (void)finish:(void(^)(id responseObject, NSError *error))finished;

@end
