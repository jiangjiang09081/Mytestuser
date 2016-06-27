//
//  DBRegisterModule.m
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBRegisterModule.h"

@implementation DBRegisterModule

+ (DBRegisterModule *)shareModule{
    
    static DBRegisterModule *registerModule = nil;
    
    if (!registerModule) {
        registerModule = [[DBRegisterModule alloc]init];
    }
    return registerModule;
}

@end
