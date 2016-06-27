//
//  DBShoppingModule.m
//  DBShopping
//
//  Created by jiang on 16/4/6.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBShoppingModule.h"

@implementation DBShoppingModule

+ (DBShoppingModule *)shareModule{
    
    static DBShoppingModule *shoppingModule = nil;
    if (!shoppingModule) {
        shoppingModule = [[DBShoppingModule alloc]init];
    }
    return shoppingModule;
}

//获取海外幻灯片
- (void)getMobileSlide:(void (^)(id responseObject, NSError *error))finished{
    NSString *url = [NSString stringWithFormat:@"Api/slider"];
    [self GetWithUrl:url AndParameter:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        finished (responseObject, nil);
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        finished (nil,error);
    }];
}
/**
 *  获取关键字
 *  http://duobao.sysvi.cn/Api/activity_list  key=name    value=搜索条件
 */

- (void)getSearchResultWithKeyWords:(NSString *)keyword finish:(void (^)(id, NSError *))finished{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [parameter setObject:keyword forKey:@"value"];
    [parameter setObject:@"name" forKey:@"key"];
    
    [self postWithUrl:@"Api/activity_list"  AndParameter:parameter finish:^(id responseObject, NSError *error) {
        finished (responseObject, error);
    }];
}



@end
