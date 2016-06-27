//
//  DBCartModule.m
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBCartModule.h"

@implementation DBCartModule

+ (DBCartModule *)shareModule{
    static DBCartModule *cartModule = nil;
    if (!cartModule) {
        cartModule = [[DBCartModule alloc]init];
    }
    return  cartModule;
}
@end
