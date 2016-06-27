//
//  DBDetileViewController.m
//  DBShopping
//
//  Created by jiang on 16/3/29.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBDetileViewController.h"
#import "SDCycleScrollView.h"
#import "DBLoginViewController.h"
#import "DBChooseGoodinfo.h"
#import "CartViewController.h"
#import "DBOrderPayViewController.h"
#import "DBShoppingCart.h"
#define SDScrollViewTag 70
#define ButtonTag 100
static NSString *cellID = @"cellID";

@interface DBDetileViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *sdScrollView;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *groupArray;

@property (nonatomic, strong) DBChooseGoodinfo *choseGoodinfo;
@property (nonatomic, strong) NSMutableDictionary *descData;
@property (nonatomic, strong) UILabel *name_label;
@property (nonatomic, strong) UILabel *needLabel;
@property (nonatomic, strong) UILabel *onlyLabel;
@property (nonatomic, strong) UIButton *attendButton;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIButton *cartButton;

@property (nonatomic, strong) NSMutableArray *cartArray;
@property (nonatomic, strong) NSDictionary *goodDic;
@property (nonatomic) int numOfShop;
@property (nonatomic, assign) BOOL numberChaged;

@property (nonatomic, strong) NSString *str;

@property (nonatomic, strong) UILabel *cartrightnum;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *cat_id;
@end

@implementation DBDetileViewController

- (instancetype)initWithGoodID:(NSString *)goodID{
    self = [super init];
    if (self) {
        
        _numOfShop = 1;
        self.goods_ID = goodID;
        _cartArray = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

#pragma mark 视图加载
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    self.tabBarController.tabBar.hidden = YES;
    UIColor *colorOne = [UIColor colorWithRed:(33/255.0) green:(33/255.0) blue:(33/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(33/255.0) green:(33/255.0) blue:(33/255.0) alpha:0.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = CGRectMake(0, 0, MainWidth, 64);
    
    [self.view.layer insertSublayer:headerLayer atIndex:0];
    
    self.navigationController.navigationBarHidden = YES;
    

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark 懒加载
- (NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSMutableArray *)groupArray{

    if (_groupArray == nil) {
        
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;

}


- (void)viewDidLoad {
    [super viewDidLoad];
      _numOfShop = 1;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:244/255.0 blue:247/255.0 alpha:1];

    [self createHeadView];
    // Do any additional setup after loading the view.
}

#pragma mark - 创建tableView 头视图
- (void)createHeadView{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 350)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.userInteractionEnabled = YES;
    _headView = headView;
    _headView.clipsToBounds = NO;
    [self.view addSubview:headView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 100, 45)];
    label.text = @"Details";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];

    [self.view addSubview:label];
    [self.view addSubview:backButton];
    
    NSArray *array1 = @[@"  Product datails", @"  Historical records"];
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headView.frame.size.height + 64 +10 + i*40, MainWidth, 39)];
        label.text = [array1 objectAtIndex:i];
        label.userInteractionEnabled = YES;
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor whiteColor];
        label.clipsToBounds = YES;
        label.font = [UIFont boldSystemFontOfSize:12];
       
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth - 50, 10, 20, 20)];
        [button setTitle:@">" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = ButtonTag + i;
        
        [label addSubview:button];
        
        [self.view addSubview:label];
        
    }
    //Join now
    UIButton *joinButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5,(MainWidth - 70) / 2, 40)];
    joinButton.backgroundColor = [UIColor colorWithRed:1/255.0 green:170/255.0 blue:246/255.0 alpha:1];
    [joinButton setTitle:@"Join now" forState:UIControlStateNormal];
    joinButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [joinButton addTarget:self action:@selector(joinButton:) forControlEvents:UIControlEventTouchUpInside];
    joinButton.layer.cornerRadius = 2.0;
    
    //Add to wishlish
    UIButton *wishButton = [[UIButton alloc] initWithFrame:CGRectMake((MainWidth - 70) / 2 + 20, 5, (MainWidth - 50) / 2, 40)];
    wishButton.backgroundColor = [UIColor whiteColor];
    wishButton.layer.borderWidth = 1;
    wishButton.layer.borderColor = [UIColor colorWithRed:1/255.0 green:170/255.0 blue:246/255.0 alpha:1].CGColor;
    [wishButton setTitle:@"Add to wishlist" forState:UIControlStateNormal];
    wishButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [wishButton setTitleColor:[UIColor colorWithRed:1/255.0 green:170/255.0 blue:246/255.0 alpha:1]forState:UIControlStateNormal];
    wishButton.layer.cornerRadius = 2.0;
    [wishButton addTarget:self action:@selector(wishClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cartButton = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth - 35, 10, 30, 30)];
    [cartButton setImage:[UIImage imageNamed:@"1@2x"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(cartButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //购物车图标
    _cartrightnum = [[UILabel alloc] initWithFrame:CGRectMake(17, 3, 15, 15)];
    _cartrightnum.backgroundColor = [UIColor colorWithRed:1/255.0 green:170/255.0 blue:246/255.0 alpha:1];
    _cartrightnum.textColor = [UIColor whiteColor];
    _cartrightnum.clipsToBounds = YES;
    _cartrightnum.layer.cornerRadius = 8.0;
    _cartrightnum.textAlignment = NSTextAlignmentCenter;
    _cartrightnum.font = [UIFont systemFontOfSize:10];
    
    DBShoppingCart *shoppingCart = [_HTSET.managerModule getShoppingCartGoods];
    NSString *count;
    //用户登录后
    if (_HTSET.loginModule.isUserLogin) {
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        int number = 0;
        for (NSDictionary *goods in [[[shoppingCart.goods objectForKey:@"userLogin"] objectForKey:str] objectForKey:@"loginsaveArray"]) {
            NSString *num = [goods objectForKey:@"number"];
            number += [num intValue];
        }
        count = [NSString stringWithFormat:@"%d", number];
        
    }else{
    
        int number = 0;
        for (NSDictionary *goods in [[shoppingCart.goods objectForKey:@"userNoLogin"] objectForKey:@"saveArr"]) {

            NSString *num = [goods objectForKey:@"number"];
            number += [num intValue];
          
        }
        count = [NSString stringWithFormat:@"%d", number];
    }
    _cartrightnum.text = count;
    
    if ([count length] == 0) {
        _cartrightnum.hidden = YES;
    }else{
    
        _cartrightnum.hidden = NO;
    }
    [cartButton addSubview:_cartrightnum];
    
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, MainHeight - 50, MainWidth, 50)];
    cellView.backgroundColor = [UIColor whiteColor];
    cellView.clipsToBounds = YES;
    cellView.userInteractionEnabled = YES;
    [cellView addSubview:joinButton];
    [cellView addSubview:wishButton];
    [cellView addSubview:cartButton];
    
    [self.view addSubview:cellView];
    
    [self.groupArray addObject:array1];
    
    [self loadData];
    
    
}


//购物车的点击事件

- (void)cartButton:(UIButton *)button{

    CartViewController *cart = [[CartViewController alloc] init];
    cart.isPush = YES;
    cart.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cart animated:YES];
}
/**
 *cell点击效果
 */
- (void)cellClick:(UIButton *)button{
    

}

//Join now
- (void)joinButton:(UIButton *)button{
  
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    
    if (str && [str length] > 0) {
        
        [self wishClick:button];
        _isJoinOK = YES;
        
    }else{
        
        _isJoinOK = NO;
        _HTSET.loginModule.isUserLogin = NO;
        
        DBLoginViewController *login = [[DBLoginViewController alloc] init];

        [self.navigationController pushViewController:login animated:YES];
        
    }
    
}

//Add to wishlist
- (void)wishClick:(UIButton *)button{
   
    DBChooseGoodinfo *choseGoodInfo = [[DBChooseGoodinfo alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    _choseGoodinfo = choseGoodInfo;
    [self.navigationController.view addSubview:_choseGoodinfo];
    
    CGFloat height = 0;
    UIView *goodsInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, height, MainWidth, 200)];
    goodsInfoView.userInteractionEnabled = YES;
    goodsInfoView.backgroundColor = [UIColor whiteColor];
    [_choseGoodinfo.choseBodyView addSubview:goodsInfoView];
    
    height += 15;
    //Quantity
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 200, 30)];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"Quantity";
    [goodsInfoView addSubview:label];
    
    //点击X
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth - 40, 15, 20, 20)];
    [backButton setImage:[UIImage imageNamed:@"矩形 1@2x"] forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.alpha = 0.5;
    [backButton addTarget:self action:@selector(chaClick) forControlEvents:UIControlEventTouchUpInside];
    [goodsInfoView addSubview:backButton];
    
    height += 30 + 10;
    
    //number
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 200, 20)];
    numberLabel.text = @"number";
    numberLabel.textColor = [UIColor grayColor];
    numberLabel.font = [UIFont systemFontOfSize:14];
    numberLabel.backgroundColor = [UIColor clearColor];
    [goodsInfoView addSubview:numberLabel];
    
    height += 10;
   
    //加号减号
    UIView *editNumberView = [self getEditNumViewHeight:height];
    
    [goodsInfoView addSubview:editNumberView];
    
    height += 80;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height, MainWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.5;
    [goodsInfoView addSubview:lineView];
    
    height += 5;
    
    //Join now
    UIButton *joinNowButton = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth / 2 - 120, height, 240, 40)];
    joinNowButton.backgroundColor = [UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000];
    [joinNowButton setTitle:@"Join now" forState:UIControlStateNormal];
    joinNowButton.layer.cornerRadius = 3.0;
    [joinNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    joinNowButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [joinNowButton addTarget:self action:@selector(joinNowButton:) forControlEvents:UIControlEventTouchUpInside];
    [goodsInfoView addSubview:joinNowButton];
    
    
    
}

//判断添加购物车还是直接购买
- (void)joinNowButton:(UIButton *)button{
    
    [_choseGoodinfo dismiss];
    
    NSMutableDictionary *orderGoodInfo = [NSMutableDictionary dictionaryWithCapacity:10];
    
    //直接购买
    if (_isJoinOK == YES) {
       
        DBOrderPayViewController *pay = [[DBOrderPayViewController alloc] init];
        pay.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:pay animated:YES];
        
        _isJoinOK = NO;
    }else{
        
        DBShoppingCart *shoppingCart = [_HTSET.managerModule getShoppingCartGoods];
       
        
        if (_HTSET.loginModule.isUserLogin) {
            
           NSMutableArray *loginsaveArray = [NSMutableArray arrayWithCapacity:10];
            
           NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            
            NSLog(@"%@", str);
           NSArray *array = [[[shoppingCart.goods objectForKey:@"userLogin"] objectForKey:str] objectForKey:@"loginsaveArray"];
            
           [loginsaveArray addObjectsFromArray:array];
            
            BOOL has = NO;
            
            for (NSDictionary *goodDic in loginsaveArray) {

                //根据CartID和GoodID判断是否购物车有一样的商品
                //新的数据请求
                NSString *orderGoodID = [_goodDic objectForKey:@"goods_id"];
                NSString *cart_id = [_goodDic objectForKey:@"cat_id"];
    
                //购物车已经存在的数据
                NSString *goodID = [goodDic objectForKey:@"good_id"];
                NSString *oldcart_ID = [goodDic objectForKey:@"cat_id"];
                
                if ([goodID isEqualToString:orderGoodID]) {
                    
                    if ([oldcart_ID isEqualToString:cart_id]) {
                        
                        [loginsaveArray removeObject:goodDic];
                        
                        int num = [[goodDic objectForKey:@"number"] intValue];
                        _numOfShop += num;
                        [orderGoodInfo setObject:[NSNumber numberWithInt:_numOfShop] forKey:@"number"];
                        [orderGoodInfo setObject:_cat_id forKey:@"cat_id"];
                        [orderGoodInfo setObject:_goodDic forKey:@"goodDic"];
                        [orderGoodInfo setObject:_imageUrl forKey:@"original_img"];
                        [orderGoodInfo setObject:_name_label.text forKey:@"goods_name"];
                        [orderGoodInfo setObject:_needLabel.text forKey:@"needs"];
                        [orderGoodInfo setObject:_onlyLabel.text forKey:@"only"];
                        [orderGoodInfo setObject:_goods_ID forKey:@"good_id"];
                        [loginsaveArray addObject:orderGoodInfo];
                        has = YES;
                        break;
                    }
                }
            }
            
            if (!has) {
                
                [orderGoodInfo setObject:[NSNumber numberWithInt:_numOfShop] forKey:@"number"];
                [orderGoodInfo setObject:_goods_ID forKey:@"good_id"];
                [orderGoodInfo setObject:_imageUrl forKey:@"original_img"];
                [orderGoodInfo setObject:_name_label.text forKey:@"goods_name"];
                [orderGoodInfo setObject:_needLabel.text forKey:@"needs"];
                [orderGoodInfo setObject:_onlyLabel.text forKey:@"only"];
                [orderGoodInfo setObject:_goodDic forKey:@"goodDic"];
                [orderGoodInfo setObject:_cat_id forKey:@"cat_id"];
                [loginsaveArray addObject:orderGoodInfo];
            }
            
            [_HTSET.managerModule.userLoginToken setObject:loginsaveArray forKey:@"loginsaveArray"];
            [_HTSET.managerModule.userLogin setObject:_HTSET.managerModule.userLoginToken forKey:str];
            
             NSLog(@"%@",shoppingCart.goods);
            int count = 0;
            
            for (NSDictionary *goods in loginsaveArray) {
                
                NSString *number = [goods objectForKey:@"number"];
                
                count += [number intValue];
            }
            if ([loginsaveArray count] == 0) {
                
                _cartrightnum.hidden = YES;
            }
            else{
                
                _cartrightnum.hidden = NO;
                
                _cartrightnum.text = [NSString stringWithFormat:@"%d", count];
            }
            
//            if ([_HTSET.managerModule saveDataToCoreData]) {
//                
//            }
//        
//            [self showAlertViewWithMessage:@"添加商品成功"];

        }
        
        
        //用户未登录
        else{
          
        NSMutableArray *saveArr = [NSMutableArray arrayWithCapacity:10];
            
        NSArray *array = [[shoppingCart.goods objectForKey:@"userNoLogin"] objectForKey:@"saveArr"];
        
        
            
        [saveArr addObjectsFromArray:array];
        //判断购物车是否有商品
        BOOL has = NO;
            
        for (NSDictionary *goodDic in saveArr) {
            
            //根据CartID和GoodID判断是否购物车有一样的商品
            //新的数据请求
            NSString *orderGoodID = [_goodDic objectForKey:@"goods_id"];
            NSString *cart_id = [_goodDic objectForKey:@"cat_id"];
            
            //购物车已经存在的数据
            NSString *goodID = [goodDic objectForKey:@"good_id"];
            NSString *oldcart_ID = [goodDic objectForKey:@"cat_id"];
            
            if ([goodID isEqualToString:orderGoodID]) {
                
                if ([oldcart_ID isEqualToString:cart_id]) {
                    
                [saveArr removeObject:goodDic];
                    
                int num = [[goodDic objectForKey:@"number"] intValue];
                _numOfShop += num;
                [orderGoodInfo setObject:[NSNumber numberWithInt:_numOfShop] forKey:@"number"];
                [orderGoodInfo setObject:_cat_id forKey:@"cat_id"];
                [orderGoodInfo setObject:_goodDic forKey:@"goodDic"];
                [orderGoodInfo setObject:_imageUrl forKey:@"original_img"];
                [orderGoodInfo setObject:_name_label.text forKey:@"goods_name"];
                [orderGoodInfo setObject:_needLabel.text forKey:@"needs"];
                [orderGoodInfo setObject:_onlyLabel.text forKey:@"only"];
                [orderGoodInfo setObject:_goods_ID forKey:@"good_id"];
                [saveArr addObject:orderGoodInfo];
                has = YES;
                break;
                }
            }
        }
        
        if (!has) {
            
            [orderGoodInfo setObject:[NSNumber numberWithInt:_numOfShop] forKey:@"number"];
            [orderGoodInfo setObject:_goods_ID forKey:@"good_id"];
            [orderGoodInfo setObject:_imageUrl forKey:@"original_img"];
            [orderGoodInfo setObject:_name_label.text forKey:@"goods_name"];
            [orderGoodInfo setObject:_needLabel.text forKey:@"needs"];
            [orderGoodInfo setObject:_onlyLabel.text forKey:@"only"];
            [orderGoodInfo setObject:_goodDic forKey:@"goodDic"];
            [orderGoodInfo setObject:_cat_id forKey:@"cat_id"];
            [saveArr addObject:orderGoodInfo];
        }
            
            [_HTSET.managerModule.userNoLogin setObject:saveArr forKey:@"saveArr"];
            
           NSLog(@"%@",shoppingCart.goods);
           int count = 0;
        
        for (NSDictionary *goods in saveArr) {
            
            NSString *number = [goods objectForKey:@"number"];
            
            count += [number intValue];
        }
        if ([saveArr count] == 0) {
            
            _cartrightnum.hidden = YES;
        }
        else{
        
            _cartrightnum.hidden = NO;
            _cartrightnum.text = [NSString stringWithFormat:@"%d", count];
        }
      
    }
        shoppingCart.goods = _HTSET.managerModule.good;
        
        if ([_HTSET.managerModule saveDataToCoreData]) {
            
        }
        [self showAlertViewWithMessage:@"添加商品成功"];
    }
 
}

- (void)addToUserShoppingCartWithGoodDic:(NSDictionary *)dic{
    
    
    
}

- (UIView *)getEditNumViewHeight:(CGFloat)height{
    
    UIView *editView = [[UIView alloc] initWithFrame:CGRectMake(10, height + 25, 90, 30)];
    editView.layer.borderColor = HEXCOLOR(0xdcdcdc).CGColor;
    editView.userInteractionEnabled = YES;
    editView.layer.borderWidth = 1.0;
    
    //减号
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minusBtn.frame = CGRectMake(0, 0, 30, 30);
    minusBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [minusBtn setTitleColor:_HTTHEME.colorProjectTextColor forState:UIControlStateNormal];
    [minusBtn setTitleColor:_HTTHEME.colorProjectGrayTextColor forState:UIControlStateDisabled];
    [minusBtn addTarget:self action:@selector(minusAction:) forControlEvents:UIControlEventTouchUpInside];
    minusBtn.tag = 130;
    minusBtn.enabled = _numOfShop > 1;
    [editView addSubview:minusBtn];
    
    UILabel *numLbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 30, 30)];
    numLbl.font = [UIFont systemFontOfSize:14];
    numLbl.backgroundColor = [UIColor clearColor];
    numLbl.textColor = [UIColor orangeColor];
    numLbl.textAlignment = NSTextAlignmentCenter;
    numLbl.text = [NSString stringWithFormat:@"%d",_numOfShop];
    numLbl.tag = 131;
    _numLabel = numLbl;
    [editView addSubview:_numLabel];
    
    //加号
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    plusButton.frame = CGRectMake(60, 0, 30, 30);
    plusButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [plusButton setTitle:@"+" forState:UIControlStateNormal];
    [plusButton setTitleColor:_HTTHEME.colorProjectTextColor forState:UIControlStateNormal];
    [plusButton setTitleColor:_HTTHEME.colorProjectGrayTextColor forState:UIControlStateDisabled];
    [plusButton addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
    plusButton.tag = 132;
    [editView addSubview:plusButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 1, 30)];
    line.backgroundColor = HEXCOLOR(0xdcdcdc);
    [editView addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 1, 30)];
    line.backgroundColor = HEXCOLOR(0xdcdcdc);
    [editView addSubview:line];
    
    return editView;
}

//减
- (void)minusAction:(UIButton *)button{
    
    _numOfShop--;
    
    if (_numOfShop == 1) {
        
        button.enabled = NO;
    }


    _numLabel.text = [NSString stringWithFormat:@"x%d",_numOfShop];
    [(UILabel *)[button.superview viewWithTag:131] setText:[NSString stringWithFormat:@"%d",_numOfShop]];
}

//加
- (void)plusAction:(UIButton *)button{
    
    _numOfShop++;
    _numLabel.text = [NSString stringWithFormat:@"x%d",_numOfShop];
    [(UIButton *)[button.superview viewWithTag:130] setEnabled:_numOfShop > 1];
    [(UILabel *)[button.superview viewWithTag:131] setText:[NSString stringWithFormat:@"%d",_numOfShop]];
    
}

- (void)chaClick{

    [_choseGoodinfo dismiss];
}

/**
 *  显示头视图
 */
- (void)setContent{
    
    [_sdScrollView removeFromSuperview];
    
    NSMutableArray *sliderArr = [NSMutableArray arrayWithCapacity:10];
    
    for (NSDictionary *dic in _images) {
        
        if ([[dic objectForKey:@"img_original"] length] > 0) {
            
            NSString *img = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"Public%@",[dic objectForKey:@"img_original"]]];
            [sliderArr addObject:img];
        }
    }
    if ([sliderArr count] > 0) {
        _sdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MainWidth, 200) imagesGroup:sliderArr];
        _sdScrollView.delegate = self;
        _sdScrollView.autoScrollTimeInterval = 5.0;
        _sdScrollView.pageControl.hidesForSinglePage = YES;
        _sdScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        [_headView addSubview:_sdScrollView];
    }
}

//滚动栏点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
 
    
}



- (void)loadData{
  
    [_HTSET.commodityModule getGoodsID:_goods_ID success:^(id responseObject, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            _goodDic = [responseObject objectForKey:@"data"];
            
            _descData = [NSMutableDictionary dictionaryWithCapacity:10];
            
            _descData = [responseObject objectForKey:@"data"];
            
            //根据ID判断
            _cat_id = [_descData objectForKey:@"cat_id"];
            
            _images = [_descData objectForKey:@"image"];
            
            _name_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH - 20, 50)];
            _name_label.textColor = [UIColor blackColor];
            _name_label.font = [UIFont boldSystemFontOfSize:14];
            _name_label.numberOfLines = 0;
            _name_label.text = [_descData objectForKey:@"goods_name"];
            [_headView addSubview:_name_label];
            
            
            _needLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 280, 100, 30)];
            _needLabel.text = [NSString stringWithFormat:@"Need:%@",_needs];
            _needLabel.textColor = [UIColor blackColor];
            _needLabel.textAlignment = NSTextAlignmentLeft;
            _needLabel.font = [UIFont systemFontOfSize:12];
            _needLabel.alpha = 0.5;
            [_headView addSubview:_needLabel];
            
            _onlyLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth - 100, 280, 90, 30)];
            _onlyLabel.text = [NSString stringWithFormat:@"Only:%@",_only];
            _onlyLabel.textColor = [UIColor blackColor];
            _onlyLabel.font = [UIFont systemFontOfSize:12];
            _onlyLabel.textAlignment = NSTextAlignmentRight;
            _onlyLabel.alpha = 0.5;
            [_headView addSubview:_onlyLabel];
            
            
            _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 260, SCREEN_WIDTH - 20, 30)];
            _progressView.trackTintColor = [UIColor grayColor];
            _progressView.progressTintColor = [UIColor colorWithRed:254/255.0 green:171/255.0 blue:64/255.0 alpha:1];
            _progressView.progress = ([_needs floatValue] - [_only floatValue])/[_needs floatValue];
            [_headView addSubview:_progressView];
            
            _attendButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 310, MainWidth - 20, 30)];
            _attendButton.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:239/255.0 alpha:1];
            _attendButton.layer.cornerRadius = 4.0;
            _attendButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
            [_attendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_attendButton setTitle:@"You did not attend the event!" forState:UIControlStateNormal];
            [_attendButton addTarget:self action:@selector(attendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:_attendButton];
            
            NSString *imgStr = [[responseObject objectForKey:@"data"]objectForKey:@"original_img"];
            
            imgStr = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"Public%@",imgStr]];
            _imageUrl = imgStr;
        }
        [_HTSET getCommonInformation:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
        
        [self setContent];
    }];
}
//暂时没用
- (void)attendButtonClick:(UIButton *)button{
    
  
}

- (void)back:(UIButton *)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
