//
//  DBChangeInfoViewViewController.m
//  DBShopping
//
//  Created by jiang on 16/5/10.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBChangeInfoViewViewController.h"

@interface DBChangeInfoViewViewController ()

@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) NSString *name;

@end

@implementation DBChangeInfoViewViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViews];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.nameTextField becomeFirstResponder];
}

- (void)addSubViews{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 30, 25)];
    [backButton setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *labelButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 200, 30)];
    labelButton.backgroundColor = [UIColor clearColor];
    [labelButton setTitle:@"Nickname" forState:UIControlStateNormal];
    labelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    labelButton.titleLabel.textColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:labelButton];
    self.navigationItem.leftBarButtonItems = @[item,item1];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIView *textFieldView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 10, MainWidth, 30)];
    textFieldView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, MainWidth - 20, 30)];
    textField.font = [UIFont systemFontOfSize:14];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.text = _name;
    _nameTextField = textField;
    [textFieldView addSubview:_nameTextField];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 29, MainWidth - 20, 1)];
    lineView.backgroundColor = HEXRGBCOLOR(0XF0F0F0);
    [textFieldView addSubview:lineView];
}


- (void)back:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save:(UIBarButtonItem *)item{

    [_nameTextField resignFirstResponder];
    
    if ([_nameTextField.text length] == 0) {
        [self showAlertViewWithMessage:@"姓名不能为空"];
        
    }else{
    
        self.changeNameBlock (_nameTextField.text);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
