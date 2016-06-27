//
//  DBLoginViewController.h
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBaseViewController.h"

@interface DBLoginViewController : DBBaseViewController

@property (nonatomic, copy) void(^loginSucceedBlock)();
@property (nonatomic, copy) void(^cancelLoginBlock)();

@end
