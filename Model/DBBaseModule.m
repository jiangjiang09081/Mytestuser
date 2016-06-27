//
//  DBBaseModule.m
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBaseModule.h"
#import "WrappedHUDHelper.h"
@implementation DBBaseModule
- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
        
        _manager.requestSerializer.timeoutInterval = 60;
    }
    return self;
}

- (void)postWithUrl:(NSString *)url
       AndParameter:(id)parameter
             finish:(void(^)(id, NSError *))finished{
    
    [_manager POST:url parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[WrappedHUDHelper sharedHelper]hideHUD];
        
        finished (responseObject,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [[WrappedHUDHelper sharedHelper]hideHUD];
        
        finished (error,nil);
    }];
}

- (NSURLSessionDataTask *)GETWithParameter:(NSDictionary *)parameter isForced:(BOOL)isForced success:(Complicate)complicate failure:(Filure)failure{
    return nil;
}

- (NSURLSessionDataTask *)GETWithParameter:(NSDictionary *)parameter success:(Complicate)complicate failure:(Filure)failure{
    return [self GETWithParameter:parameter isForced:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        complicate (task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure (task,error);
    }];
}

- (NSURLSessionDataTask *)GetWithUrl:(NSString *)url AndParameter:(NSDictionary *)parameter success:(Complicate)complicate failuer:(Filure)failure{
    NSURLSessionDataTask *theTask = [_manager GET:url
                                       parameters:parameter
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              complicate (task, responseObject);
                                          }
                                          failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              failure (task, error);
                                          }];
    return theTask;
}
@end
