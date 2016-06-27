//
//  DBEditAddressViewController.h
//  DBShopping
//
//  Created by jiang on 16/5/18.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBBaseViewController.h"

@interface DBEditAddressViewController : DBBaseViewController

@property (nonatomic, copy) void (^operateSuccess)();

@property (nonatomic, strong) NSDictionary *data;

@end
