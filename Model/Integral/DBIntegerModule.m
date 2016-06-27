//
//  DBIntegerModule.m
//  DBShopping
//
//  Created by jiang on 16/3/28.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBIntegerModule.h"

@implementation DBIntegerModule

+ (DBIntegerModule *)shareModule{

    static DBIntegerModule *integerModule = nil;
    if (!integerModule) {
        integerModule = [[DBIntegerModule alloc]init];
    }
    return integerModule;
}

@end
