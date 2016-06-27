//
//  DBActivityModule.m
//  DBShopping
//
//  Created by jiang on 16/4/20.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBActivityModule.h"

@implementation DBActivityModule

+(DBActivityModule *)ShareModule{

    static DBActivityModule *module = nil;
    if (!module) {
        module = [[DBActivityModule alloc] init];
    }
    return module;
}

- (void)getRegimentListWithType:(NSString *)type success:(void (^)(id, NSError *))finished{

    NSString *url = [NSString stringWithFormat:@"Api/filter_record/token/32f2bf7/p/1/type/starting"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:10];
    [parameters setObject:type forKey:@"type"];
    
    [self GetWithUrl:url AndParameter:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        finished(responseObject, nil);
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        finished(error, nil);
    }];
}


@end
