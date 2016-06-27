//
//  CartViewController.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "CartViewController.h"
#import "DBShoppingCart.h"
#import "DBCartTableViewCell.h"
@interface CartViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *underView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nullLabel;
@property (nonatomic, strong) UIButton *checkoutButton;
@property (nonatomic, strong) UILabel *totalName;
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation CartViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
   [self getGoodsInShoppingCart];
    
    
    
}

//获取购物车数据
- (void)getGoodsInShoppingCart{

    [_dataSource removeAllObjects];
    
    NSMutableArray *allGoodArr = [NSMutableArray arrayWithCapacity:10];
    //判断用户是否登录来获取购物车数据
    if (_HTSET.loginModule.isUserLogin) {
       
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        DBShoppingCart *shoppingCart = [_HTSET.managerModule getShoppingCartGoods];
        
        [allGoodArr addObjectsFromArray:[[[shoppingCart.goods objectForKey:@"userLogin"] objectForKey:str] objectForKey:@"loginsaveArray"]];
        
    }
    //未登录用户
    else{
     
        DBShoppingCart *shoppingCart = [_HTSET.managerModule getShoppingCartGoods];

        [allGoodArr addObjectsFromArray:[[shoppingCart.goods objectForKey:@"userNoLogin"] objectForKey:@"saveArr"]];
    }
    _dataSource = allGoodArr;
    if (!_dataSource || [_dataSource count] == 0) {
        _tableView.hidden = YES;
        _imageView.hidden = NO;
        _nullLabel.hidden = NO;
        //后续补充
        return;
        
    }else{
    
        _tableView.hidden = NO;
        _imageView.hidden = YES;
        _nullLabel.hidden = YES;
    }
    
    if ([_dataSource count] > 0) {
        
        int count = 0;
        for (NSDictionary *dic in _dataSource) {
            
            NSString *number = [dic objectForKey:@"number"];
            count += [number intValue];
        }
        
        _totalName.text = [NSString stringWithFormat:@"All %ld Commodity,subtotal",_dataSource.count];
        _priceLabel.text = [NSString stringWithFormat:@"￥%d.0",count];
    }
    
    [_tableView reloadData];
}

//重新加载用户购物车
- (void)reloadUserShoppingCart{

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cart" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editGoods:)];
    _dataSource = [NSMutableArray arrayWithCapacity:10];
    [self addSubView];
    // Do any additional setup after loading the view.
}

//edit编辑按钮
- (void)editGoods:(UIBarButtonItem *)item{


    
}

- (void)addSubView{
    
//    DBShoppingCart *cart = [_HTSET.managerModule getShoppingCartGoods];
//    
//    _dataSource = cart.goods;

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MainWidth, MainHeight - 40 - 64 - 44) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView reloadData];
    [self.view addSubview:_tableView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MainWidth/2 - 50, MainHeight/2 - 50 , 100, 100)];
    _imageView.image = [UIImage imageNamed:@"emptyShoppingCart"];
    _imageView.layer.cornerRadius = 35;
    [self.view addSubview:_imageView];
    _nullLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/2 - 50, MainHeight/2 + 60, 100, 30)];
    _nullLabel.text = @"购物车为空";
    _nullLabel.textColor = [UIColor grayColor];
    _nullLabel.backgroundColor = [UIColor clearColor];
    _nullLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nullLabel];
    
    if ([_dataSource count] > 0) {
        
        _tableView.hidden = NO;
        _imageView.hidden = YES;
        _nullLabel.hidden = YES;
        
    }else{
    
        _tableView.hidden = YES;
        _imageView.hidden = NO;
        _nullLabel.hidden = NO;
    
    }
    
    _underView = [[UIView alloc] initWithFrame:CGRectMake(0, MainHeight - 40 - 50, MainWidth, 40)];
    _underView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    _underView.userInteractionEnabled = YES;
    [self.view addSubview:_underView];
    
    _checkoutButton = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth - 100, 5, 80, 30)];
    _checkoutButton.backgroundColor = [UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000];
    [_checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
    _checkoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _checkoutButton.layer.cornerRadius = 3.0;
    [_checkoutButton addTarget:self action:@selector(checkoutButton:) forControlEvents:UIControlEventTouchUpInside];
    [_underView addSubview:_checkoutButton];
    
    _totalName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
    _totalName.backgroundColor = [UIColor clearColor];
    _totalName.textColor = [UIColor grayColor];
    _totalName.font = [UIFont systemFontOfSize:12];
    _totalName.textAlignment = NSTextAlignmentLeft;
    [_underView addSubview:_totalName];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 50, 40)];
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.textColor = [UIColor orangeColor];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    [_underView addSubview:_priceLabel];
    
    
    if (_isPush) {
        
        self.navigationItem.leftBarButtonItem = nil;
        _tableView.frame = CGRectMake(0, 64, MainWidth, MainHeight - 64 - 40);
        _underView.frame = CGRectMake(0, MainHeight - 40, MainWidth, 40);
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cartCell";
    DBCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[DBCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [cell setContentWithData:_dataSource[indexPath.row]];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;
}
//下面view的button
- (void)checkoutButton:(UIButton *)button{

    
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
