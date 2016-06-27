
//
//  DBBindViewController.m
//  DBShopping
//
//  Created by jiang on 16/5/10.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBindViewController.h"
#import "BLBaseUIHelper.h"
@interface DBBindViewController ()

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *passTextField;
@property (nonatomic, strong) UITextField *controlTextField;

@property (nonatomic, strong) UIView *bodyView;
@property (nonatomic, assign) BOOL isBind;

@end

@implementation DBBindViewController

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
    
     _isBind = NO;
    
    if ([_string length] > 0) {
        _isBind = YES;
    }
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:244/255.0 blue:247/255.0 alpha:1];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 30, 25)];
    [backButton setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *labelButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 200, 30)];
    labelButton.backgroundColor = [UIColor clearColor];
    [labelButton setTitle:@"Account number" forState:UIControlStateNormal];
    labelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    labelButton.titleLabel.textColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:labelButton];
    self.navigationItem.leftBarButtonItems = @[item,item1];
    
    [self addSubView];
    // Do any additional setup after loading the view.
}

- (void)back:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addSubView{

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(DoneClick:)];
    _bodyView = [[UIView alloc] initWithFrame:CGRectMake(10, 64+15, MainWidth - 20, 150)];
    _bodyView.backgroundColor = [UIColor whiteColor];
    _bodyView.layer.cornerRadius = 3.0;
    _bodyView.layer.borderWidth = 1.0;
    _bodyView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_bodyView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(30, _bodyView.size.height /3 , self.bodyView.size.width - 30, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.bodyView addSubview:lineView];
    
    UIView *usernameInputView  = [BLBaseUIHelper basePasswordViewWithFrame:CGRectMake(0, 0, _bodyView.size.width , _bodyView.size.height / 3) leftIcon:@"形状 2" placeholder:@"Email"];
    usernameInputView.backgroundColor = [UIColor clearColor];
    _nameTextField = (UITextField *)[usernameInputView viewWithTag:2];
    _nameTextField.autocapitalizationType = UITextAutocorrectionTypeNo;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextField.font = [UIFont boldSystemFontOfSize:14];
    _nameTextField.secureTextEntry = NO;
    [self.bodyView addSubview:usernameInputView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(30,(_bodyView.size.height /3) * 2, self.bodyView.size.width - 30, 1)];
    lineView1.backgroundColor = [UIColor grayColor];
    [self.bodyView addSubview:lineView1];
    
    //密码
    UIView *passWordInputView = [BLBaseUIHelper basePasswordViewWithFrame:CGRectMake(0, _bodyView.size.height/3 + 1, _bodyView.size.width, _bodyView.size.height/3) leftIcon:@"形状 3" placeholder:@"Password"];
    passWordInputView.backgroundColor = [UIColor clearColor];
    _passTextField = (UITextField *)[passWordInputView viewWithTag:2];
    _passTextField.font = [UIFont boldSystemFontOfSize:14];
    _passTextField.secureTextEntry = YES;
    [self.bodyView addSubview:passWordInputView];
    
    UIView *passWordInputView1 = [BLBaseUIHelper basePasswordViewWithFrame:CGRectMake(0, (_bodyView.size.height/3 )*2 + 1, _bodyView.size.width, _bodyView.size.height/3) leftIcon:@"形状 3" placeholder:@"Confirm Password"];
    passWordInputView1.backgroundColor = [UIColor clearColor];
    _controlTextField = (UITextField *)[passWordInputView1 viewWithTag:2];
    _controlTextField.font = [UIFont boldSystemFontOfSize:14];
    _controlTextField.secureTextEntry = YES;
    [self.bodyView addSubview:passWordInputView1];
}

//邮箱地址的正则表达式
- (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)DoneClick:(UIBarButtonItem *)button{

    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    if (email && [email length] > 0) {
        
        [self showAlertViewWithMessage:@"已经绑定邮箱"];
        
    }else{
        
    if ([self isValidateEmail:_nameTextField.text] == YES) {
        
        if ([_passTextField.text isEqualToString:_controlTextField.text] == YES){
            
            [_HTSET.minModule bindEmail:_nameTextField.text passWorld:_passTextField.text finish:^(id responseObject, NSError *error) {
                
                if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                    
                    NSString * message = [responseObject objectForKey:@"message"];
                    
                    if ([message isEqualToString:@"success"] == YES) {
                        
                        _HTSET.loginModule.isUserLogin = YES;
                        
                        _isBind = YES;
                        
                        self.changeNumberBlock ? _changeNumberBlock (_nameTextField.text):nil;
                        
                        [self showAlertViewWithMessage:@"绑定邮箱成功"];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:_nameTextField.text forKey:@"email"];
                        [[NSUserDefaults standardUserDefaults] setObject:_passTextField.text forKey:@"pwd"];
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else{
                        
                        _HTSET.loginModule.isUserLogin = NO;
                        
                        _isBind = NO;

                        [self showAlertViewWithMessage:@"邮箱已经被使用"];
                    }
                }
                
            }];
            
        }else{
            
            [self showAlertViewWithMessage:@"两次密码输入不一致"];
        }
    }else{
    
        [self showAlertViewWithMessage:@"邮箱格式不正确"];
    }
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
