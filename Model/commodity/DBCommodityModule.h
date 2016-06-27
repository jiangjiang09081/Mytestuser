//
//  DBCommodityModule.h
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBBaseModule.h"

@interface DBCommodityModule : DBBaseModule

+ (DBCommodityModule *)ShareModule;

- (void)getRegimentListWithType:(NSString *)type
                        success:(void(^)(id responseObject,NSError *error))finished;

/**
 *  获取商品详情接口
 */

- (void)getGoodsID:(NSString *)goods_ID success:(void (^)(id responseObject, NSError *error))finished;

@end
