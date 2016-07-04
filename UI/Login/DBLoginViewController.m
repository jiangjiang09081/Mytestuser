//
//  DBLoginViewController.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBLoginViewController.h"
#import "BLBaseUIHelper.h"
#import "DBForgetPassWordViewController.h"
#import "DBRegisterModule.h"
#import "DBMeModule.h"
#import "DBLoginModule.h"
#import "DBRegisterViewController.h"
#import "MeViewController.h"
#import "DBDataSettingViewController.h"
#import "DBShoppingCart.h"
#import "MBProgressHUD.h"

#import "WXApi.h"
#import "WXApiObject.h"
#import "UMSocial.h"
#import "UMSocialControllerService.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialConfig.h"
#import "UMSocialAccountManager.h"
#import "UMSocialData.h"
@interface DBLoginViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,WXApiDelegate>
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIScrollView *bodyScrollView;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *logButton;
@property (nonatomic, strong) UINavigationController *nav;
@property (nonatomic, assign) BOOL LoginInProgress;
@property (nonatomic, strong) NSString *oauthId;
@property (nonatomic, strong) NSMutableDictionary *userInfo;
@property (nonatomic, strong) MBProgressHUD *mbProgressHud;
@end

@implementation DBLoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _userInfo = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000]];
    [self addLogView];
    
    // Do any additional setup after loading the view.
}

- (void)addLogView{
    
    _bodyScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MainWidth, MainHeight - 64)];
    _bodyScrollView.backgroundColor = HEXCOLOR(0xFFFFFF);
    _bodyScrollView.userInteractionEnabled = YES;
    _bodyScrollView.delegate = self;
    _bodyScrollView.showsVerticalScrollIndicator = NO;
    _bodyScrollView.contentSize = CGSizeMake(MainWidth, MainHeight - 64);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    tap.delegate = self;
    //设置属性 点击此次 1单击 2 双击
    tap.numberOfTapsRequired = 1;
    //单点触控 还是多点触控
    tap.numberOfTouchesRequired = 1;
    [_bodyScrollView addGestureRecognizer:tap];
    [self.view addSubview:_bodyScrollView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(15, 30, 20, 20);
    backButton.clipsToBounds = YES;
    [backButton setBackgroundImage:[UIImage imageNamed:@"backwhite"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    backButton.backgroundColor = HEXRGBCOLOR(0x64697b);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"Log in" style:UIBarButtonItemStylePlain target:nil action:nil];
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HEXCOLOR(0xFFFFFF),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItems = @[item,item1];
    
    
    UIView *bodyView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, MainWidth - 20, 101)];
    bodyView.clipsToBounds = YES;
    bodyView.layer.borderWidth = 1.0;
    bodyView.backgroundColor =  HEXRGBCOLOR(0XFFFFFF);
    //边框颜色
    bodyView.layer.borderColor = HEXRGBCOLOR(0XE3E4D8).CGColor;
    [_bodyScrollView addSubview:bodyView];
    
    UIView *usernameInputView  = [BLBaseUIHelper basePasswordViewWithFrame:CGRectMake(0, 0, bodyView.size.width, bodyView.size.height / 2) leftIcon:@"形状 2" placeholder:@"Address"];
    usernameInputView.backgroundColor = [UIColor clearColor];
    _usernameTextField = (UITextField *)[usernameInputView viewWithTag:2];
    _usernameTextField.autocapitalizationType = UITextAutocorrectionTypeNo;
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameTextField.font = [UIFont boldSystemFontOfSize:14];
    _usernameTextField.secureTextEntry = NO;
    
    //中间横线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, bodyView.size.height / 2, bodyView.size.width, 1)];
    lineView.backgroundColor = HEXRGBCOLOR(0XE3E4D8);
    
    //密码
    UIView *passWordInputView = [BLBaseUIHelper basePasswordViewWithFrame:CGRectMake(0, bodyView.size.height/2 + 1, bodyView.size.width, bodyView.size.height/2) leftIcon:@"形状 3" placeholder:@"Password"];
    passWordInputView.backgroundColor = [UIColor clearColor];
    _passwordTextField = (UITextField *)[passWordInputView viewWithTag:2];
    _passwordTextField.font = [UIFont boldSystemFontOfSize:14];
    _passwordTextField.secureTextEntry = YES;
    
    UIButton *forgetbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetbutton.frame = CGRectMake(bodyView.frame.size.width - 100, 5, 90, 29);
    forgetbutton.backgroundColor = HEXRGBCOLOR(0XFFFFFF);
    [forgetbutton setTitle:@"Forget?" forState:UIControlStateNormal];
    forgetbutton.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [forgetbutton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [passWordInputView addSubview:forgetbutton];
    
    [bodyView addSubview:usernameInputView];
    [bodyView addSubview:passWordInputView];
    [bodyView addSubview:lineView];
    
    //登录
    _logButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logButton.frame = CGRectMake(10, 140, MainWidth - 20, 50);
    _logButton.backgroundColor = [UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000];
    [_logButton setTitle:@"Login" forState:UIControlStateNormal];
    _logButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _logButton.layer.cornerRadius = 2.0;
    [_logButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_bodyScrollView addSubview:_logButton];
    
    UIView *secondView  = [[UIView alloc]initWithFrame:CGRectMake(10, _bodyScrollView.frame.size.height / 2, MainWidth - 20, 40)];
    secondView.userInteractionEnabled = YES;
    secondView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, secondView.frame.size.width, 30)];
    label.text = @"You can also";
    label.textColor = [UIColor grayColor];
    label.alpha = 0.3;
    label.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:label];
    
    CGFloat buttonWidth = MainWidth / 7;
    CGFloat buttonHeight = buttonWidth;
    
    for (int i = 0; i < 3; i++) {
        UIButton *thirdPartyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        thirdPartyButton.frame = CGRectMake((i * 2 + 1)*buttonWidth, _bodyScrollView.frame.size.height / 2 + 50, buttonWidth, buttonHeight);
        thirdPartyButton.backgroundColor = [UIColor clearColor];
        thirdPartyButton.clipsToBounds = YES;
        thirdPartyButton.tag = i + 50;
        UILabel *thirdlabel = [[UILabel alloc]initWithFrame:CGRectMake((i * 2 + 1)*buttonWidth, _bodyScrollView.frame.size.height/2 + 55 + buttonHeight, buttonWidth + 10, 40)];
        if (i == 0) {
            [thirdPartyButton setBackgroundImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
            thirdlabel.text = @"facebook";
        }else if (i == 1){
            [thirdPartyButton setBackgroundImage:[UIImage imageNamed:@"google"] forState:UIControlStateNormal];
            thirdlabel.text = @"google";
        }else{
            [thirdPartyButton setBackgroundImage:[UIImage imageNamed:@"twitter"] forState:UIControlStateNormal];
            thirdlabel.text = @"twitter";
        }
        thirdlabel.font = [UIFont systemFontOfSize:12];
        thirdlabel.alpha = 0.5;
        
        [thirdPartyButton addTarget:self action:@selector(gotoThirdPartyView:) forControlEvents:UIControlEventTouchUpInside];
        [_bodyScrollView addSubview:thirdPartyButton];
        [_bodyScrollView addSubview:thirdlabel];
    }
    
    [_bodyScrollView addSubview:secondView];

    
}

- (void)login{
    
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    if (_usernameTextField.text == nil || [_usernameTextField.text isEqualToString:@""]) {
        [self showAlertViewWithMessage:@"请输入用户名"];
        return;
    }else{
        
     if (_passwordTextField.text == nil || [_passwordTextField.text isEqualToString:@""]) {
        [self showAlertViewWithMessage:@"请输入密码"];
        return;
     }else{
         [[WrappedHUDHelper sharedHelper] showHUDInView:self.view withTitle:@"正在登录"];
         [_HTSET.loginModule loginWithemail:_usernameTextField.text AndPassword:_passwordTextField.text finish:^(NSString *message) {
            
             if ([message isEqualToString:@"success"] == YES) {
                 [[WrappedHUDHelper sharedHelper] hideHUD];
                 
                 MeViewController *me = [[MeViewController alloc] init];
                 
                 [me refreshData];
    
                 [self getUserInfo];
                 
                 [self.navigationController pushViewController:me animated:YES];
                 
             }else{
                 
                 [self showAlertViewWithMessage:message];
             }
             
             
         }];
     }
    
    }
    
    
    [self.view endEditing:YES];
   
    
}

- (void)getUserInfo{
    
    [_HTSET.minModule returnUserInformation:^(id responseObject, NSError *error) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self saveShoppingCart];
        }
        
    }];
    
}

- (void)saveShoppingCart{
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    DBShoppingCart *shoppingCart = [_HTSET.managerModule getShoppingCartGoods];
    NSArray *arrData = [[[shoppingCart.goods objectForKey:@"userLogin"] objectForKey:str] objectForKey:@"loginsaveArray"];
    
    if ([arrData count] > 0) {
        [_HTSET.managerModule saveDataToCoreData];
        [_HTSET getUserShoppingCart];
    }
    
    
}
//第三方登录
- (void)gotoThirdPartyView:(UIButton *)button{
  
    switch (button.tag - 50) {
        case 0:{
        
            [self sendAuthRequest];
        }
            break;
        case 1:{
            [UMSocialData setAppKey:@"2238228476"];
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            snsPlatform.loginClickHandler(self, [UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *response){
            
                
            });
        }
            break;
            
        default:
            break;
    }
    
}

- (void)sendAuthRequest{
    //检查微信是否被用户安装
    if ([WXApi isWXAppInstalled]) {
    
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"0744";
        [WXApi sendReq:req];
    }else{
    
        [self setupAlertController];
    }

}
//根据返回信息获取用户微信token
- (void)onResp:(BaseResp *)resp{

    if (resp.errCode == 0) {
        SendAuthResp *sendResp = (SendAuthResp *)resp;
        NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx76f1fe821ac5c89e&secret=c1c252e6ac0e15d51204eb0e14d84b19&code=%@&grant_type=authorization_code",sendResp.code];
        [_HTSET.loginModule getTokenFromThirdWithUrl:url finish:^(id responseObject, NSError *error) {
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                NSString *accessToken = [responseObject objectForKey:@"access_token"];
                NSString *openId = [responseObject objectForKey:@"openid"];
                [self getWeiChatUserInfoWithAccessToken:accessToken openId:openId];
            }
        }];
    }
}

//获取微信的个人信息
- (void)getWeiChatUserInfoWithAccessToken:(NSString *)accesstoken openId:(NSString *)openId{

    [_HTSET.loginModule getWeiChatUserInfoWithAccessToken:accesstoken openId:openId finishen:^(id responseObject, NSError *error) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
//            NSString *userName = [responseObject objectForKey:@"nickname"];
//            NSString *userId = [responseObject objectForKey:@"unionid"];
            
        }
    }];
}

//设置提示未安装微信
- (void)setupAlertController{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


//忘记密码的点击事件
- (void)onClick:(UIButton *)button{
    
//    DBRegisterViewController *rv = [[DBRegisterViewController alloc]init];
//    [self.navigationController pushViewController:rv animated:YES];
}
//手势的事件
- (void)tapView:(UIGestureRecognizer *)tap{
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}
//返回按钮
- (void)back:(UIButton *)button{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
