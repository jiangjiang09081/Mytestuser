//
//  DBCommodityModule.m
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBCommodityModule.h"

@implementation DBCommodityModule

+ (DBCommodityModule *)ShareModule{

    static DBCommodityModule *commodityModule = nil;
    if (!commodityModule) {
        commodityModule = [[DBCommodityModule alloc]init];
    }
    return commodityModule;
}
//获取分期活动列表
- (void)getRegimentListWithType:(NSString *)type success:(void (^)(id responseObject, NSError * error))finished{
    
    NSString *url = [NSString stringWithFormat:@"Api/term_list/type/complete"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:10];
    [parameters setObject:type forKey:@"type"];
    [self GetWithUrl:url AndParameter:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        finished(responseObject, nil);
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        finished(error, nil);
    }];

    
}

- (void)getGoodsID:(NSString *)goods_ID success:(void (^)(id, NSError *))finished{
    
    NSString *url = [NSString stringWithFormat:@"Api/goods_info/goods_id/1"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:10];
    [parameters setObject:goods_ID forKey:@"goods_id"];
    [self GetWithUrl:url AndParameter:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        finished (responseObject, nil);
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        finished (error, nil);
    }];
}

@end
