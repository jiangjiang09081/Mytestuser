//
//  DBDataSettingViewController.h
//  DBShopping
//
//  Created by jiang on 16/4/15.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBaseViewController.h"

@interface DBDataSettingViewController : DBBaseViewController

@property (nonatomic, strong) UIButton *headImageButton;
@property (nonatomic, strong) UIButton *signoutButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *emailLabel;

@property (nonatomic, copy) void (^changeImageBlock)(UIImage *image);

@property (nonatomic, copy) void (^changeNameBlock)(NSString *name);

@property (nonatomic, copy) void (^signOutSuccess)();

@end
