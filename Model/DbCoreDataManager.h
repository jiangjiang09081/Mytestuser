//
//  DbCoreDataManager.h
//  DBShopping
//
//  Created by jiang on 16/4/22.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DBShoppingCart.h"
@interface DbCoreDataManager : NSObject
@property (nonatomic, strong) NSMutableDictionary *userNoLogin;
@property (nonatomic, strong) NSMutableDictionary *userLogin;
@property (nonatomic, strong) NSMutableDictionary *userLoginToken;
@property (nonatomic, strong) NSMutableDictionary *good;

+ (DbCoreDataManager *)shareModule;

- (BOOL)saveDataToCoreData;


- (DBShoppingCart *)getShoppingCartGoods;


@end
