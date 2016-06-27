//
//  DBChangeInfoViewViewController.h
//  DBShopping
//
//  Created by jiang on 16/5/10.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBaseViewController.h"

@interface DBChangeInfoViewViewController : DBBaseViewController

@property (nonatomic, strong) void (^changeNameBlock)(NSString *name);

- (instancetype)initWithName:(NSString *)name;


@end
