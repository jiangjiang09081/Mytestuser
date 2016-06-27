//
//  SearchTableViewCell.m
//  DBShopping
//
//  Created by jiang on 16/4/7.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "SearchTableViewCell.h"
@interface SearchTableViewCell ()

@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UIButton *cartImageView;

@property (nonatomic, strong) UILabel *goods_name;
@property (nonatomic, strong) UILabel *term_auto;
@property (nonatomic, strong) UILabel *term_num;

@property (nonatomic,strong) UIView *lineView;

@end
@implementation SearchTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellStyleDefault;
         [self addSubViews];
    }

    return self;
}

- (void) addSubViews{

    //商品图片
    _goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    _goodsImageView.clipsToBounds = YES;
    
    //商品名
    _goods_name = [[UILabel alloc]init];
    _goods_name.frame = CGRectMake(80, 10, MainWidth - 80 - 60, 50);
    _goods_name.textColor = [UIColor blackColor];
    _goods_name.font = [UIFont systemFontOfSize:12];
    _goods_name.textAlignment = NSTextAlignmentLeft;
    _goods_name.numberOfLines = 0;
    
    //Need
    _term_auto = [[UILabel alloc]init];
    _term_auto.frame = CGRectMake(80, self.frame.size.height + _goods_name.frame.size.height - 10, 50, 30);
    _term_auto.textColor = [UIColor blackColor];
    _term_auto.font = [UIFont systemFontOfSize:10];
    _term_auto.alpha = 0.5;
    _term_auto.textAlignment = NSTextAlignmentLeft;
    
    //Only
    _term_num = [[UILabel alloc]init];
    _term_num.frame = CGRectMake(self.goodsImageView.frame.size.width + self.goods_name.frame.size.width - 40, self.frame.size.height + _goods_name.frame.size.height  - 10, 50, 30);
    _term_num.textColor = [UIColor blackColor];
    _term_num.font = [UIFont systemFontOfSize:10];
    _term_num.alpha = 0.5;
    _term_num.textAlignment = NSTextAlignmentLeft;
    
    //竖线
    _lineView = [[UIView alloc] initWithFrame:CGRectMake( MainWidth - 40, 10, 1, 90)];
    _lineView.backgroundColor = [UIColor blackColor];
    _lineView.alpha = 0.1;
    
    //购物车
    _cartImageView = [[UIButton alloc]init];
    _cartImageView.frame = CGRectMake(MainWidth - 35, 30, 30, 50);
    [_cartImageView setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    [_cartImageView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_cartImageView];
    [self addSubview:_lineView];
    [self addSubview:_goods_name];
    [self addSubview:_term_num];
    [self addSubview:_term_auto];
    [self addSubview:_goodsImageView];
}

- (void)setContentWithData:(NSDictionary *)data{

    NSString *imgstr = [[data objectForKey:@"goods"] objectForKey:@"original_img"];
    imgstr = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"Public%@",imgstr]];
    
    NSURL *url = [NSURL URLWithString:imgstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __weak __block typeof (UIImageView *) weakImageView = _goodsImageView;
    [_goodsImageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"default_pictures"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        CGRect frame = [image getImageFrameWithFrame:weakImageView.frame];
        weakImageView.frame = frame;
        weakImageView.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    _goods_name.text = [[data objectForKey:@"goods"] objectForKey:@"goods_name"];
    _term_auto.text = [NSString stringWithFormat:@"Only:%@",[data objectForKey:@"term_num"]];
    _term_num.text = [NSString stringWithFormat:@"Need:%@",[data objectForKey:@"term_auto" ]];
}

- (void)click:(UIButton *)button{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
