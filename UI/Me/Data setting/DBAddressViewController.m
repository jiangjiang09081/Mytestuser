//
//  DBAddressViewController.m
//  DBShopping
//
//  Created by jiang on 16/5/12.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBAddressViewController.h"
#import "DBAddAddressViewController.h"
#import "DBAddressTableViewCell.h"
#import "DBEditAddressViewController.h"
@interface DBAddressViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *selectAddress;

@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIView *cleckView;
@property (nonatomic, strong) UIButton *cleckButton;

//无记录
@property (nonatomic, strong) UIButton *addAddressButton;
@property (nonatomic, strong) UILabel *noDataLabel1;
@property (nonatomic, strong) UILabel *noDataLabel2;

@end

@implementation DBAddressViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 30, 25)];
    [backButton setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *labelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, 200, 30)];
    labelButton.backgroundColor = [UIColor clearColor];
    [labelButton setTitle:@"Receiving address" forState:UIControlStateNormal];
    labelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    labelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    labelButton.titleLabel.textColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:labelButton];
    self.navigationItem.leftBarButtonItems = @[item,item1];
    [self addSubViews];
    [self refreshData];
    // Do any additional setup after loading the view.
}

- (void)addSubViews{

    _cleckView = [[UIView alloc] initWithFrame:CGRectMake(0, MainHeight - 50, MainWidth, 50)];
    _cleckView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cleckView];
    
    _cleckButton = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth / 2 - 50, 10, 100, 30)];
    _cleckButton.backgroundColor = [UIColor whiteColor];
    _cleckButton.layer.borderWidth = 1.0;
    _cleckButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _cleckButton.layer.borderColor = [UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.0].CGColor;
    [_cleckButton setTitle:@"Add address" forState:UIControlStateNormal];
    [_cleckButton setTitleColor:[UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000] forState:UIControlStateNormal];
    _cleckButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_cleckButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [_cleckView addSubview:_cleckButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MainWidth, MainHeight - 114) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.hidden = YES;
   
    
}

//刷新界面
- (void)refreshData{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [_HTSET.minModule getReceivedGoodsAddressListWithToken:token finish:^(id responseObject, NSError *error) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
         
            if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            
          NSArray *arr = [responseObject objectForKey:@"data"];
            
            if (arr.count > 0) {
                
                self.tableView.hidden = NO;
                
                _dataArr = arr;
                
                [_tableView reloadData];
                
            }else{
            
                self.tableView.hidden = YES;
            }
            }
            
        }
    }];
}


#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"DBAddressCell";
    DBAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell) {
        
        cell = [[DBAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        
    }

    
    NSString *str = [[_dataArr objectAtIndex:indexPath.section] objectForKey:@"is_usual"];
    
    if ([str isEqualToString:@"1"]) {
        
        [cell setContentWithData:[_dataArr objectAtIndex:indexPath.section] isDefault:YES];
    }
    else{
    
        [cell setContentWithData:[_dataArr objectAtIndex:indexPath.section] isDefault:NO];
    }
    
    cell.deleteBlock = ^(NSString *addressID){
      
        [self deleteaddressWith:addressID];
        
        [self refreshData];
        
    };
    return cell;
}

- (void)deleteaddressWith:(NSString *)addressID{

    
    [_HTSET.minModule deleteAddressWithID:addressID finish:^(id responseObject, NSError *error) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSString *message = [responseObject objectForKey:@"message"];
            
            if ([message isEqualToString:@"success"] == YES) {
                
                [self showAlertViewWithMessage:@"删除成功"];
            }
            
            [_HTSET getCommonInformation:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
        }
      }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;
}
//设置组头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DBEditAddressViewController *edit = [[DBEditAddressViewController alloc] init];
    
    edit.operateSuccess = ^(){
    
        [self refreshData];
        
    };
    edit.data = [_dataArr objectAtIndex:indexPath.section];
    
    [self.navigationController pushViewController:edit animated:YES];
    
}

- (void)click:(UIButton *)button{
    
    DBAddAddressViewController *add = [[DBAddAddressViewController alloc] init];
    
    add.operateSuccess = ^{
    
        [self refreshData];
    };
    
    [self.navigationController pushViewController:add animated:YES];
}

- (void)back:(UIButton *)button{

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
