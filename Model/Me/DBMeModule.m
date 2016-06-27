//
//  DBMeModule.m
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBMeModule.h"

@implementation DBMeModule

+  (DBMeModule *)shareModule{
    static DBMeModule *meModule = nil;
    if (!meModule) {
        meModule = [[DBMeModule alloc]init];
    }
    return meModule;
}

- (instancetype)init{

    self = [super init];
    if (self) {
        
        self.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        self.email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
        
        if (self.email > 0) {
            
            _HTSET.loginModule.isUserLogin = YES;
        }
    }
    return self;
}

//创建新用户接口
- (void)getPersionalInfoFinish:(void(^) (id, NSError *))finished{

    
    [self GetWithUrl:@"Api/user/create_user" AndParameter:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        finished (responseObject, nil);
        
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        
        finished (error, nil);
    }];
}

//已经登录过的用户获取个人信息接口
- (void)getCommonInformationWithParameters:(NSString *)str finish:(void (^)(id, NSError *))finished{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [parameters setObject:str forKey:@"token"];
    
    NSString *urlPath = [NSString stringWithFormat:@"Api/user/get_userinfo_bytoken/token/%@",str];
    [self GetWithUrl:urlPath AndParameter:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        finished (responseObject, nil);
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        
        finished (error, nil);
    }];
}

//修改头像接口
- (void)changeHeadImageWithImage:(UIImage *)image finish:(void (^)(id, NSError *))finished{

    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *urlPath = [NSString stringWithFormat:@"Api/Upload/upload_sub"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:10];
    
    
    [parameters setObject:image forKey:@"image"];
    
    if ([imageData length] > 0) {
        [self.manager POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"submit.jpg" mimeType:@"image/jpeg"];
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            finished (responseObject, nil);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            finished (error, nil);
        }];
    }
}

//修改用户个人信息接口
- (void)updatePersionalInfoWithParameter:(NSDictionary *)parameter finish:(void (^)(id, NSError *))finished{
    
    NSString *url = [NSString stringWithFormat:@"Api/edit_userinfo/token/%@",_HTSET.minModule.token];

    [self postWithUrl:url AndParameter:parameter finish:^(id responseObject, NSError *error) {
       
        finished (responseObject, error);
    }];
    
    
}

//更改用户昵称接口

- (void)changeUserName:(NSString *)name finish:(void (^)(id, NSError *))finished{

//    NSString *url = [NSString stringWithFormat:@"Api/edit_name/token/%@/name/%@",self.token, name];
    NSString *url = [NSString stringWithFormat:@"Api/edit_name/token/%@/",self.token];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:10];
    [parameter setObject:self.token forKey:@"token"];
    [parameter setObject:name forKey:@"name"];
    [self GetWithUrl:url AndParameter:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        finished (responseObject, nil);
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        finished (error, nil);
    }];
}

//返回用户信息接口

- (void)returnUserInformation:(void (^)(id, NSError *))finished{
    
    NSString *url = [NSString stringWithFormat:@"Api/user/get_userinfo_bytoken/token/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
//    NSLog(@"%@", url);
    
    [self GetWithUrl:url AndParameter:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        finished (responseObject, nil);
        
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        
        finished (error, nil);
    }];
}

/**
 *  绑定邮箱并设置密码接口
 */

- (void)bindEmail:(NSString *)email passWorld:(NSString *)pass finish:(void(^)(id, NSError *))finished{

    NSString *url = [NSString stringWithFormat:@"Api/band_email/email/%@/pwd/%@/token/%@",email, pass, self.token];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:10];
    [parameter setObject:email forKey:@"email"];
    [parameter setObject:pass forKey:@"pass"];
    [parameter setObject:self.token forKey:@"token"];
    
    [self GetWithUrl:url AndParameter:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        finished (responseObject, nil);
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        finished (error, nil);
    }];
}

//保存地址
- (void)saveAddressWithParameter:(NSDictionary *)parameter finish:(void (^)(id, NSError *))finish{
    
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    NSString *mobile = [parameter objectForKey:@"mobile"];
//    NSString *name = [parameter objectForKey:@"consignee"];
//    NSString *address = [parameter objectForKey:@"address"];
//
//    NSString *url = [NSString stringWithFormat:@"Api/add_addr/mobile/%@/token/%@/consignee/%@/address/%@",mobile,token,name,address];
    
    NSString *url = @"Api/add_addr";
    
    [self postWithUrl:url AndParameter:parameter finish:^(id responseObject, NSError *error) {
        
        finish (responseObject, error);
    }];
    
}

//地址列表
- (void)getReceivedGoodsAddressListWithToken:(NSString *)token finish:(void (^)(id, NSError *))finish{
    
    NSString *url = [NSString stringWithFormat:@"Api/get_addr_list/token/%@",token];
    
    [self postWithUrl:url AndParameter:nil finish:^(id responseObject, NSError *error) {
        
        finish (responseObject, error);
    }];
}

//更改地址列表接口
- (void)updateAddressListWithParameter:(NSDictionary *)parameter finish:(void (^)(id, NSError *))finished{

//    NSString *assress_id = [parameter objectForKey:@"address_id"];
//    NSString *mobile = [parameter objectForKey:@"mobile"];
//    NSString *token = [parameter objectForKey:@"token"];
//    NSString *name = [parameter objectForKey:@"consignee"];
//    NSString *address = [parameter objectForKey:@"city"];
    

//    NSString *url = [NSString stringWithFormat:@"Api/edit_addr/address_id/%@/mobile/%@/token/%@/consignee/%@/address/%@", assress_id, mobile, token, name, address];
    
    NSString *url = @"Api/edit_addr";
    
    [self postWithUrl:url AndParameter:parameter finish:^(id responseObject, NSError *error) {
       
        finished (responseObject, error);
    }];
}


//删除地址列表接口
- (void)deleteAddressWithID:(NSString *)address finish:(void (^)(id, NSError *))finished{

    NSString *url = [NSString stringWithFormat:@"Api/addr_del/address_id/%@/token/%@", address, [[NSUserDefaults standardUserDefaults]objectForKey:@"token"]];
    
    [self postWithUrl:url AndParameter:nil finish:^(id responseObject, NSError *error) {
        
        finished (responseObject, error);
    }];
    
}
@end
