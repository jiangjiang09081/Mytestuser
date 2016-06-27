//
//  DBCartTableViewCell.m
//  DBShopping
//
//  Created by jiang on 16/5/20.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBCartTableViewCell.h"
@interface DBCartTableViewCell()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *needLabel;
@property (nonatomic, strong) UILabel *onlyLabel;
@property (nonatomic, strong) UIView *countView;
@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *minNusButton;
@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation DBCartTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellStyleDefault;
        
        [self addSubViews];
    }
    return self;
    
}

- (void)addSubViews{
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    _image.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_image];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, MainWidth - 80, 40)];
    _name.backgroundColor = [UIColor whiteColor];
    _name.textColor = [UIColor blackColor];
    _name.font = [UIFont systemFontOfSize:12];
    _name.numberOfLines = 0;
    _name.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_name];
    
    _needLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 55, 80, 20)];
    _needLabel.backgroundColor = [UIColor clearColor];
    _needLabel.textColor = [UIColor grayColor];
    _needLabel.font = [UIFont systemFontOfSize:10];
    _needLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_needLabel];
    
    _onlyLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 55, 80, 20)];
    _onlyLabel.backgroundColor = [UIColor clearColor];
    _onlyLabel.textColor = [UIColor grayColor];
    _onlyLabel.font = [UIFont systemFontOfSize:10];
    _onlyLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_onlyLabel];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth / 2 - 15, 85, 40, 30)];
    _numberLabel.layer.borderWidth = 1;
    _numberLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.textColor = [UIColor orangeColor];
    _numberLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_numberLabel];
    
}

- (void)setContentWithData:(NSDictionary *)data{
    
    NSString *str = [data objectForKey:@"original_img"];
    if (str &&[str length] > 0) {
        NSURL *url = [NSURL URLWithString:str];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        __weak __block typeof (UIImageView *)weakIconView = _image;
//        __weak __block typeof (self)weakSelf = self;
        [_image setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"default_pictures"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            weakIconView.image = image;
//            weakIconView.frame = (id)_image.frame;
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
    }else{
        
        _image.image = [UIImage imageNamed:@"default_pictures"];
    }
    
    _name.text = [[data objectForKey:@"goodDic"] objectForKey:@"goods_name"];
    _needLabel.text = [data objectForKey:@"needs"];
    _onlyLabel.text = [data objectForKey:@"only"];
    _numberLabel.text = [[data objectForKey:@"number"] stringValue];
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
