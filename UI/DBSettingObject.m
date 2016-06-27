//
//  DBSettingObject.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBSettingObject.h"

@implementation DBSettingObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _loginModule = [DBLoginModule shareModule];
        _registerModule = [DBRegisterModule shareModule];
        _minModule = [DBMeModule shareModule];
        _integerModule = [DBIntegerModule shareModule];
        _cartModule = [DBCartModule shareModule];
        _commodityModule = [DBCommodityModule ShareModule];
        _shoppingModule = [DBShoppingModule shareModule];
        _activityModule = [DBActivityModule ShareModule];
        _managerModule = [DbCoreDataManager shareModule];
    }
    return self;
}



////新登录的用户获取token
- (void)getTokenInformation{

    [_HTSET.minModule getPersionalInfoFinish:^(id responseObject, NSError * error) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            self.minModule.data = [responseObject objectForKey:@"data"];
            
            self.minModule.token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
       

            [[NSUserDefaults standardUserDefaults] setObject:self.minModule.token forKey:@"token"];
            
            _HTSET.loginModule.isUserLogin = NO;
        }
    }];

    
}
//已经登录的用户获取个人信息
- (void)getCommonInformation:(NSString *)token{
    
    //收货地址
    [_HTSET.minModule getReceivedGoodsAddressListWithToken:token finish:^(id responseObject, NSError *error) {
       
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            _loginModule.addressList = [responseObject objectForKey:@"data"];
        }
        
    }];

    [_HTSET.minModule getCommonInformationWithParameters:token finish:^(id responseObject, NSError *error) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[[responseObject objectForKey:@"data"] objectForKey:@"email"] length] > 0) {
                
                _HTSET.loginModule.isUserLogin = YES;
                
                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject objectForKey:@"data"] objectForKey:@"email"] forKey:@"email"];
                
                
            }else{
            
                _HTSET.loginModule.isUserLogin = NO;
            }
        }
    } ];
    
}


//购物车
- (void)getUserShoppingCart{
  
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    DBShoppingCart *shoppingCart = [_HTSET.managerModule getShoppingCartGoods];
    NSArray *arrData = [[[shoppingCart.goods objectForKey:@"userLogin"] objectForKey:str] objectForKey:@"loginsaveArray"];
    int num = 0;
    if ([arrData count] > 0) {
     
        for (NSDictionary *dic in arrData) {
            NSString *number = [dic objectForKey:@"number"];
            num += [number intValue];
        }
    }
    _HTUI.shoppingCartNVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", num];
    
    
}


















@end
