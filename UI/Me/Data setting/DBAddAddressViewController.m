//
//  DBAddAddressViewController.m
//  DBShopping
//
//  Created by jiang on 16/5/12.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBAddAddressViewController.h"

@interface DBAddAddressViewController ()<UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UIButton *preserButton;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *streetTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UITextField *cityTextField;
@property (nonatomic, strong) UITextView *stateTextView;
@property (nonatomic, strong) UILabel *placholderLabel;
@property (nonatomic, assign) BOOL isChange;

@property (nonatomic, strong) NSDictionary *addressDic;
@property (nonatomic, strong) NSMutableDictionary *parameter;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DBAddAddressViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _parameter = [NSMutableDictionary dictionaryWithCapacity:10];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

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
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:244/255.0 blue:247/255.0 alpha:1];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 30, 25)];
    [backButton setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *labelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, 250, 30)];
    labelButton.backgroundColor = [UIColor clearColor];
    [labelButton setTitle:@"Add Receiving address" forState:UIControlStateNormal];
    labelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    labelButton.titleLabel.textColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:labelButton];
    self.navigationItem.leftBarButtonItems = @[item,item1];

    [self addSubView];
    // Do any additional setup after loading the view.
}

- (void)back:(UIButton *)button
{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addSubView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MainWidth, 350) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
   
    //姓名
    UITextField *nameTextFiele = [[UITextField alloc] initWithFrame:CGRectMake(16, 0, MainWidth - 38, 50)];
    nameTextFiele.placeholder = @"Name";
    nameTextFiele.delegate = self;
    nameTextFiele.textColor = [UIColor grayColor];
    nameTextFiele.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextFiele.font = [UIFont systemFontOfSize:16];
    _nameTextField = nameTextFiele;
    
    //街道
    UITextField *streetTextField = [[UITextField alloc] initWithFrame:CGRectMake(16, 0, MainWidth - 38, 50)];
    streetTextField.placeholder = @"Street";
    streetTextField.delegate = self;
    streetTextField.textColor = [UIColor grayColor];
    streetTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    streetTextField.font = [UIFont systemFontOfSize:16];
    _streetTextField = streetTextField;
    
    //邮编
    UITextField *codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(16, 0, MainWidth - 38, 50)];
    codeTextField.placeholder = @"Zip/Postal Code";
    codeTextField.font = [UIFont systemFontOfSize:16];
    codeTextField.delegate = self;
    codeTextField.textColor = [UIColor grayColor];
    codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeTextField = codeTextField;
    
    //手机号
    UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(16, 0, MainWidth - 38, 50)];
    numberTextField.textColor = [UIColor grayColor];
    numberTextField.placeholder = @"Phone Number";
    numberTextField.font = [UIFont systemFontOfSize:16];
    numberTextField.delegate = self;
    numberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _numberTextField = numberTextField;
    
    //城市
    UITextField *cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(16, 0, MainWidth - 38, 50)];
    cityTextField.textColor = [UIColor grayColor];
    cityTextField.placeholder = @"City";
    cityTextField.font = [UIFont systemFontOfSize:16];
    cityTextField.delegate = self;
    cityTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _cityTextField = cityTextField;
    
    //街道
    UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth - 32, 30)];
    placeholderLabel.textColor = [UIColor grayColor];
    placeholderLabel.text = @"State/Provice/Region";
    _placholderLabel = placeholderLabel;
    _placholderLabel.alpha = 0.3;
    
    UITextView *stateTextView = [[UITextView alloc] initWithFrame:CGRectMake(16, 0, MainWidth, 50)];
    stateTextView.font = [UIFont systemFontOfSize:14];
    stateTextView.delegate = self;
    _stateTextView = stateTextView;
    [_stateTextView addSubview:_placholderLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignd:)];
    tap.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:tap];
    
    _preserButton = [[UIButton alloc] initWithFrame:CGRectMake(10, MainHeight - 100, MainWidth - 20, 40)];
    _preserButton.backgroundColor = [UIColor colorWithRed:1/255.0 green:169/255.0 blue:245/255.0 alpha:1];
    [_preserButton setTitle:@"Preservation" forState:UIControlStateNormal];
    [_preserButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_preserButton addTarget:self action:@selector(saveAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_preserButton];
}


//保存地址
- (void)saveAddressAction:(UIButton *)button{

    if ([_nameTextField.text length] == 0) {
        [self showAlertViewWithMessage:@"请输入姓名"];
        return;
    }
    if ([_streetTextField.text length] == 0) {
        [self showAlertViewWithMessage:@"请输入街道名"];
        return;
    }
    if ([_codeTextField.text length] == 0) {
        [self showAlertViewWithMessage:@"请输入邮编"];
        return;
    }
    if ([_numberTextField.text length] == 0) {
        [self showAlertViewWithMessage:@"请输入手机号"];
    }else if ([_numberTextField.text length] != 11){
    
        [self showAlertViewWithMessage:@"请输入正确的手机号"];
        return;
    }
    if ([_cityTextField.text length] == 0) {
        [self showAlertViewWithMessage:@"请输入省市"];
        return;
    }
    if ([_stateTextView.text length] < 1) {
        [self showAlertViewWithMessage:@"请输入详细地址"];
        return;
    }
    [self addAddress];
}

- (void)addAddress{


    [_parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forKey:@"token"];
    [_parameter setObject:_nameTextField.text forKey:@"consignee"];
    [_parameter setObject:_streetTextField.text forKey:@"address"];
    [_parameter setObject:_numberTextField.text forKey:@"mobile"];
    [_parameter setObject:_cityTextField.text forKey:@"city"];
    [_parameter setObject:_stateTextView.text forKey:@"province"];
    [_parameter setObject:_codeTextField.text forKey:@"zipcode"];
    
    [_HTSET.minModule saveAddressWithParameter:_parameter finish:^(id responseObject, NSError *error) {
        if (!error) {
           
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                NSString *message = [responseObject objectForKey:@"message"];
                NSString *str;
                if ([message isEqualToString:@"success"]) {
                    
                    self.operateSuccess();
                    
                    str = @"保存成功";
                    
                }else{
                
                
                    str = @"保存失败";
                }
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                alert.tag = 2001;
                [alert show];
                
                NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
                
                [_HTSET getCommonInformation:token];
            }
        }else{
        
            [self showAlertViewWithMessage:@"保存失败"];
        }
    }];

  
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 2001) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"addressCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.row) {
        case 0:
        {
            [cell addSubview:_nameTextField];
        }
            break;
        case 1:{
            [cell addSubview:_streetTextField];
        
        }
            break;
        case 2:{
            [cell addSubview:_codeTextField];
        }
            break;
        case 3:{
            
            [cell addSubview:_numberTextField];
        
        }
            break;
        case 4:{
            [cell addSubview:_cityTextField];
        }
            break;
        case 5:{
            
            [cell addSubview:_stateTextView];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 5) {
        return 90;
    }else{
    
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark -textView Change

- (void)textViewDidChange:(UITextView *)textView{

    if ([textView.text length] == 0) {
        _placholderLabel.hidden = NO;
        
    }else{
    
        _placholderLabel.hidden = YES;
    }
}

//键盘显示
- (void)keyBoardWillShow:(NSNotification *)notification{

    NSDictionary *info = [notification userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat h = [aValue CGRectValue].size.height;
    [UIView animateWithDuration:0.25
                     animations:^{
                         CGSize contentsize = _tableView.contentSize;
                         contentsize.height = MainHeight - 64 + h;
                         _tableView.contentSize = contentsize;
                     }];
}

- (void)keyBoardWillHidden:(NSNotification *)notification{

    [UIView animateWithDuration:0.25
                     animations:^{
                         CGSize contentsize = _tableView.contentSize;
                         contentsize.height = MainHeight - 64;
                         _tableView.contentSize = contentsize;
                     }];
    
}

- (void)resignd:(UITapGestureRecognizer *)tap{

    [_nameTextField resignFirstResponder];
    [_streetTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [_numberTextField resignFirstResponder];
    [_cityTextField resignFirstResponder];
    [_stateTextView resignFirstResponder];
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
