
//
//  DBAddressTableViewCell.m
//  DBShopping
//
//  Created by jiang on 16/5/18.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBAddressTableViewCell.h"
@interface DBAddressTableViewCell()<UIAlertViewDelegate>


@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numberLabe;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DBAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    
    float width = 0;
    float height = 0;
    _defaultButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 15, 15)];
    [_defaultButton setImage:[UIImage imageNamed:@"address_unselect"] forState:UIControlStateNormal];
    _deleteButton.backgroundColor = [UIColor clearColor];
    [self addSubview:_defaultButton];
//
    width += 25;
    height += 25;
    _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth - 100, 10, 15, 15)];
    [_deleteButton setImage:[UIImage imageNamed:@"address_delete"] forState:UIControlStateNormal];
    _deleteButton.backgroundColor = [UIColor clearColor];
    [self addSubview:_deleteButton];
    
    UILabel *defaultLabel = [[UILabel alloc] initWithFrame:CGRectMake( width + 10, 2, 150, 30)];
    defaultLabel.text = @"Default address";
    defaultLabel.textColor = [UIColor grayColor];
    defaultLabel.font = [UIFont systemFontOfSize:12];
    defaultLabel.backgroundColor = [UIColor clearColor];
    defaultLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:defaultLabel];
    
    UILabel *deleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth - 80, 2, 80, 30)];
    deleteLabel.backgroundColor = [UIColor clearColor];
    deleteLabel.text = @"Delete";
    deleteLabel.textColor = [UIColor grayColor];
    deleteLabel.font = [UIFont systemFontOfSize:12];
    deleteLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:deleteLabel];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, height + 5, MainWidth - 20, 1)];
    _lineView.backgroundColor = [UIColor grayColor];
    _lineView.alpha = 0.3;
    [self addSubview:_lineView];
    
    height += 5;
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height + 10, 150, 20)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_nameLabel];
    
    _numberLabe = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth - 120, height + 10, 110, 20)];
    _numberLabe.backgroundColor = [UIColor clearColor];
    _numberLabe.textColor = [UIColor grayColor];
    _numberLabe.textAlignment = NSTextAlignmentRight;
    _numberLabe.font = [UIFont systemFontOfSize:12];
    [self addSubview:_numberLabe];
    
    height += 30;
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height, MainWidth - 20, 30)];
    _cityLabel.backgroundColor = [UIColor clearColor];
    _cityLabel.textColor = [UIColor grayColor];
    _cityLabel.font = [UIFont systemFontOfSize:12];
    _cityLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_cityLabel];
    
    
    
    [_defaultButton addTarget:self action:@selector(defaultClick:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setContentWithData:(NSDictionary *)data isDefault:(BOOL)isDefault{
    
    _addressID = [data objectForKey:@"address_id"];
    
    _nameLabel.text = [data objectForKey:@"consignee"];
    
    _numberLabe.text = NONullString([data objectForKey:@"mobile"]);
    
    _cityLabel.text = [NSString stringWithFormat:@"City:%@  Address:%@",[data objectForKey:@"city"],[data objectForKey:@"address"]];
    
    if (isDefault) {
        
        [_defaultButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateSelected];
        
    }else{
    
        [_defaultButton setImage:[UIImage imageNamed:@"address_unselect"] forState:UIControlStateNormal];
        
    }
}


- (void)defaultClick:(UIButton *)button{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否将其设置成默认地址" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alertView.tag = 200;
    
    [alertView show];
    
}

- (void)deleteButtonClick:(UIButton *)button{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否删除地址" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alert.tag = 201;
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 200) {
        
        if (buttonIndex == 1) {
            
            [_defaultButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];

        }else if (buttonIndex == 0){
        
            [_defaultButton setImage:[UIImage imageNamed:@"address_unselect"] forState:UIControlStateNormal];

            
        }
        
        
    }else if (alertView.tag == 201){
    
        if (buttonIndex == 1) {
            
          self.deleteBlock(_addressID);
            
        }else if (buttonIndex == 0){
        
            return;
        }
        
       
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
