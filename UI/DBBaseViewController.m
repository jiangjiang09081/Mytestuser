//
//  DBBaseViewController.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBaseViewController.h"

@interface DBBaseViewController ()



@end

@implementation DBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.opaque = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000];
    
    
    [self.view addSubview:[[UIView alloc]initWithFrame:CGRectZero]];
    
    if ([[self.navigationController viewControllers] count] > 1) {
        
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iv_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick:)];
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
    // Do any additional setup after loading the view.
}

- (void)backClick:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showAlertViewWithMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
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
