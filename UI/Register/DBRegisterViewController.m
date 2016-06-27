//
//  DBRegisterViewController.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBRegisterViewController.h"
#import "MeViewController.h"
@interface DBRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UIScrollView *registerScrollview;
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UITextField *passWordTextField;
@property (nonatomic, strong)UITextField *confirmTextField;
@property (nonatomic, assign)BOOL isProgress;


@end

@implementation DBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000]];
    [self addSubViews];
    // Do any additional setup after loading the view.
}
- (void)addSubViews{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(15, 30, 20, 20);
    backButton.clipsToBounds = YES;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = HEXRGBCOLOR(0x64697b);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"Bind mailbox" style:UIBarButtonItemStylePlain target:nil action:nil];
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HEXCOLOR(0xFFFFFF),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItems = @[item,item1];
    
    UIScrollView *registerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MainWidth, MainHeight - 64)];
    
    

}

- (void)back:(UIButton *)button{
    
    MeViewController *me = [[MeViewController alloc] init];
    
    [self.navigationController popToViewController:me animated:YES];
   
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
