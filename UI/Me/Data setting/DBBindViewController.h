//
//  DBBindViewController.h
//  DBShopping
//
//  Created by jiang on 16/5/10.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBaseViewController.h"

@interface DBBindViewController : DBBaseViewController

@property (nonatomic, copy) void(^changeNumberBlock)(NSString *number);

@property (nonatomic, strong) NSString *string;

@end
