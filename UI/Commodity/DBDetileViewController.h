//
//  DBDetileViewController.h
//  DBShopping
//
//  Created by jiang on 16/3/29.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBaseViewController.h"

@interface DBDetileViewController : DBBaseViewController

@property (nonatomic, strong) NSString *goods_ID;
@property (nonatomic, strong) NSString *needs;
@property (nonatomic, strong) NSString *only;
@property (nonatomic) BOOL isJoinOK;
- (instancetype)initWithGoodID:(NSString *)goodID;

@end
