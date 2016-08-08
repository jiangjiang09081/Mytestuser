//
//  MeViewController.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "MeViewController.h"
#import "DBSingleViewController.h"
#import "DBActivityViewController.h"
#import "DBDataSettingViewController.h"
#import "DBIntegralViewController.h"
#import "DBMessageViewController.h"
#import "DBRechargeViewController.h"
#import "DBLoginViewController.h"
#import "DBObtainViewController.h"
#import "DBUIImageView.h"

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *bodyScrollView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) DBUIImageView *imageView;
@property (nonatomic, strong) UIButton *headImageView;
@property (nonatomic, strong) UIView *lowView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UIButton *chargeButton;
@property (nonatomic, strong) UIButton *gainButton;

@property (nonatomic, strong) DBDataSettingViewController *data;
@end

@implementation MeViewController



//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:UserLoginStatusChangeNotification object:nil];
//    }
//    return self;
//}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self refreshData];
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)addSubView{
    
    _bodyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 44)];
    _bodyScrollView.backgroundColor = [UIColor colorWithRed:240/255.0 green:244/255.0 blue:247/255.0 alpha:1];
    _bodyScrollView.userInteractionEnabled = YES;
    _bodyScrollView.showsVerticalScrollIndicator =NO;
    [self.view addSubview:_bodyScrollView];
    
    _imageView = [[DBUIImageView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 200)];
    _imageView.image = [UIImage imageNamed:@"组 72"];
    [_imageView addTarget:self slecter:@selector(headClick:)];
    _imageView.userInteractionEnabled = YES;
    [_bodyScrollView addSubview:_imageView];
    
    /**
     *  毛玻璃效果
     */
    UIBlurEffect *imageeffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *imagefrosted = [[UIVisualEffectView alloc] initWithEffect:imageeffect];
    imagefrosted.frame = CGRectMake(0, 0, MainWidth, 200);
    imagefrosted.alpha = 0.2;
    [_imageView addSubview:imagefrosted];
    
    _headImageView = [[UIButton alloc] initWithFrame:CGRectMake(50, 44, 70, 70)];
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 35;
    _headImageView.layer.borderWidth = 1;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [_headImageView setImage:[UIImage imageNamed:@"组 71"] forState:UIControlStateNormal];
    [_headImageView addTarget:self action:@selector(headImage:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 65, 200, 30)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    _nameLabel.text = @"点击登录";
    [_imageView addSubview:_nameLabel];
    
    UIButton *backGroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, MainWidth, 70)];
    backGroundButton.backgroundColor = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:0.5];
    [_imageView addSubview:backGroundButton];
    
    _balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 100, 20)];
    _balanceLabel.textColor = [UIColor whiteColor];
    _balanceLabel.backgroundColor = [UIColor clearColor];
    _balanceLabel.font = [UIFont boldSystemFontOfSize:14];
    _balanceLabel.text = @"Balance:654";
    _balanceLabel.textAlignment = NSTextAlignmentCenter;
    [backGroundButton addSubview:_balanceLabel];
    
    _chargeButton = [[UIButton alloc] initWithFrame:CGRectMake((MainWidth / 2) + 20, 15, 100, 20)];
    [_chargeButton setTitle:@"Charge money" forState:UIControlStateNormal];
    [_chargeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _chargeButton.backgroundColor = [UIColor whiteColor];
    _chargeButton.layer.cornerRadius = 2.0;
    _chargeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_chargeButton addTarget:self action:@selector(chargeClick:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundButton addSubview:_chargeButton];
    
    [self addTableView];
    
}

- (void)refreshData{
    
    [_HTSET.minModule returnUserInformation:^(id responseObject,  NSError *error) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *data = [responseObject objectForKey:@"data"];
            
            if (data && [data isKindOfClass:[NSDictionary class]]) {
                
                NSString *headImgStr = [data objectForKey:@"avatar"];
                
                if (headImgStr && [headImgStr length] > 0) {
                    
                    _HTSET.loginModule.isUserLogin = YES;
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        /**
                         *  NSData卡顿,需要开启新线程
                         */
                        
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:headImgStr]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [_headImageView setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                            
                            _imageView.image = [UIImage imageWithData:imageData];
                        });
                    });
                }else{
                
                    [_headImageView setImage:[UIImage imageNamed:@"组 71"] forState:UIControlStateNormal];
                    _imageView.image = [UIImage imageNamed:@"组 72"];
                    
                }
                
                
                NSString *name = [data objectForKey:@"name"];
                if ([name isKindOfClass:[NSNull class]]) {
                    
                    name = @"";
                    _nameLabel.text = nil;
                }

                _nameLabel.text = name;
                
                [self.tableView reloadData];
            }
        }
    }];
    
}


- (void)change:(NSString *)name{

    
}
/**
 *  头视图的点击事件
 */
- (void)headImage:(UIButton *)button{
    
    if (_HTSET.loginModule.isUserLogin == YES) {
        
        
    }else{
    
        DBLoginViewController *login = [[DBLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    
    }
        
    
    
}

#pragma mark - 点击事件

- (void)headClick:(UIImageView *)image{
    
    if (_HTSET.loginModule.isUserLogin == YES) {
        
        
    }else{
    
    _HTSET.loginModule.isUserLogin = NO;
        
     DBLoginViewController *login = [[DBLoginViewController alloc] init];
     [self.navigationController pushViewController:login animated:YES];
        
    }
}
- (void)chargeClick:(UIButton *)button{


}

- (void)gainClick:(UIButton *)button{

}



- (void)addTableView{

    _dataSource = @[@[@"  Single record", @"  Activity record", @"  Obtain goods", @"  Message record"],@[@"  Recharge record", @"  Integral detail"], @[@"  Data setting"]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 205, MainWidth, MainHeight - 140 - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.sectionFooterHeight = 0;
    [self.bodyScrollView addSubview:_tableView];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (tableView.frame.size.height - 30)/ 8 ;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    DBSingleViewController *single = [[DBSingleViewController alloc] init];
                    [self .navigationController pushViewController:single animated:YES];
                
                }
                    break;
                case 1:{
                    DBActivityViewController *activity = [[DBActivityViewController alloc] init];
                    [self.navigationController  pushViewController:activity animated:YES];
                
                
                }
                    break;
                case 2:{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定清理缓存" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[WrappedHUDHelper sharedHelper] showHUDInView:self.view withTitle:@"正在清理缓存"];
                        [self removeAllCatchResponse];
                        
                    }];
                    [alertController addAction:action];
                    [self presentViewController:alertController animated:YES completion:nil];
                
                }
                    break;
                case 3:{
                    DBMessageViewController *message = [[DBMessageViewController alloc] init];
                    [self.navigationController pushViewController:message animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    DBRechargeViewController *recharge = [[DBRechargeViewController alloc] init];
                    [self.navigationController pushViewController:recharge animated:YES];
                
                }
                    break;
                case 1:{
                    DBIntegralViewController *integral = [[DBIntegralViewController alloc] init];
                    [self.navigationController pushViewController:integral animated:YES];
                
                }
                    break;
                    
                default:
                    break;
            }
        
        }
            break;
        case 2:{
            
            DBDataSettingViewController *data = [[DBDataSettingViewController alloc] init];
//            
//            data.changeImageBlock = ^ (UIImage *image) {
//                
//                [_headImageView setImage:image forState:UIControlStateNormal];
//                
//                _imageView.image = image;
//            };
//            data.changeNameBlock = ^ (NSString *name){
//            
//                _nameLabel.text = name;
//            };
            
            
            [self.navigationController pushViewController:data animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)removeAllCatchResponse{

    [[WrappedHUDHelper sharedHelper] hideHUD];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubView];
    [self refreshData];
    // Do any additional setup after loading the view.
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
