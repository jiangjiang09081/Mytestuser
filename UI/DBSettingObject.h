//
//  DBSettingObject.h
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBLoginModule.h"
#import "DBRegisterModule.h"
#import "DBMeModule.h"
#import "DBIntegerModule.h"
#import "DBCommodityModule.h"
#import "DBCartModule.h"
#import "DBShoppingModule.h"
#import "DBActivityModule.h"
#import "DbCoreDataManager.h"
@interface DBSettingObject : NSObject

@property (nonatomic, strong) DBLoginModule *loginModule;
@property (nonatomic, strong) DBRegisterModule *registerModule;
@property (nonatomic, strong) DBMeModule *minModule;
@property (nonatomic, strong) DBIntegerModule *integerModule;
@property (nonatomic, strong) DBCartModule *cartModule;
@property (nonatomic, strong) DBCommodityModule *commodityModule;
@property (nonatomic, strong) DBShoppingModule *shoppingModule;
@property (nonatomic, strong) DBActivityModule *activityModule;
@property (nonatomic, strong) DbCoreDataManager *managerModule;


/**
 *  用户首次登录获取token
 */
- (void)getTokenInformation;

/**
 *  用户已经登录的获取用户接口
 */
- (void)getCommonInformation:(NSString *)token;

/**
 *  购物车接口
 */
- (void)getUserShoppingCart;


/**
 *  修改个人信息接口
 */



@end
