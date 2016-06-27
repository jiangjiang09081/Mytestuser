//
//  DBMeModule.h
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBBaseModule.h"

@interface DBMeModule : DBBaseModule

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSString *email;

+ (DBMeModule *)shareModule;

/**
 * 创建新用户的接口
 */
- (void)getPersionalInfoFinish:(void (^)(id, NSError*))finished;

/**
 *  已经登录过的用户信息接口
 */
- (void)getCommonInformationWithParameters:(NSString *)str finish:(void (^)(id, NSError *))finished;

/**
 *  改变头像接口
 */
- (void)changeHeadImageWithImage:(UIImage *)image finish:(void(^)(id, NSError*))finished;
/**
 *  修改用户个人信息接口
 */
- (void)updatePersionalInfoWithParameter:(NSDictionary *)parameter finish:(void (^)(id, NSError *))finished;

/**
 *  更改用户昵称接口
 */

- (void)changeUserName:(NSString *)name finish:(void(^)(id, NSError*))finished;

/**
 *  根据token返回用户信息接口
 */

- (void)returnUserInformation:(void (^)(id, NSError *))finished;


/**
 *  绑定邮箱并设置密码接口
 */

- (void)bindEmail:(NSString *)email passWorld:(NSString *)pass finish:(void(^)(id, NSError *))finished;


/**
 *  添加地址
 */
- (void)saveAddressWithParameter:(NSDictionary *)parameter finish:(void(^)(id, NSError *))finish;

/**
 *  收货地址列表接口
 */

- (void)getReceivedGoodsAddressListWithToken:(NSString *)token finish:(void(^)(id, NSError*))finish;

/**
 *  修改收货地址列表接口
 */

- (void)updateAddressListWithParameter:(NSDictionary *)parameter finish:(void (^)(id, NSError *))finished;

/**
 *  删除收货地址
 */

- (void)deleteAddressWithID:(NSString *)address finish:(void(^)(id, NSError *error))finished;

@end
