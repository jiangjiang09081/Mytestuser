//
//  DBBaseModule.h
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"

static NSString *const baseUrl = @"http://duobao.sysvi.cn/";
static NSString *const defaultNetWorkError = @"当前网络故障,请稍后再试";
static NSString *const dataNetWorkError = @"返回数据异常,请稍后再试";

typedef void(^Complicate)(NSURLSessionDataTask *task ,id responseObject);
typedef void(^Filure)(NSURLSessionDataTask *task, NSError *error);

@interface DBBaseModule : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;


- (void)postWithUrl:(NSString *)url
       AndParameter:(id)parameter
             finish:(void(^)(id, NSError *))finished;

- (NSURLSessionDataTask *)GETWithParameter:(NSDictionary *)parameter
                                  isForced:(BOOL)isForced
                                   success:(Complicate)complicate
                                   failure:(Filure)failure;

- (NSURLSessionDataTask *)GETWithParameter:(NSDictionary *)parameter
                                   success:(Complicate)complicate
                                   failure:(Filure)failure;




- (NSURLSessionDataTask *)GetWithUrl:(NSString *)url
                        AndParameter:(NSDictionary *)parameter
                             success:(Complicate)complicate
                             failuer:(Filure)failure;





@end
