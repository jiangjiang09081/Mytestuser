//
//  DBAddressTableViewCell.h
//  DBShopping
//
//  Created by jiang on 16/5/18.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBAddressTableViewCell : UITableViewCell

@property (nonatomic) BOOL isDelete;

@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) NSString *addressID;

@property (nonatomic, copy) void(^deleteBlock)(NSString *addressID);

- (void)setContentWithData:(NSDictionary *)data isDefault:(BOOL)isDefault;

@end
