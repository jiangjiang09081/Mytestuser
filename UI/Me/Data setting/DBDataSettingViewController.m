//
//  DBDataSettingViewController.m
//  DBShopping
//
//  Created by jiang on 16/4/15.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBDataSettingViewController.h"
#import "DBChangeInfoViewViewController.h"
#import "DBBindViewController.h"
#import "DBLoginViewController.h"
#import "MeViewController.h"
#import "DBAddressViewController.h"
static NSString *CellID = @"tableViewCell";
@interface DBDataSettingViewController ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;


@end

@implementation DBDataSettingViewController



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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 30, 25)];
    [backButton setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *labelButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 200, 30)];
    labelButton.backgroundColor = [UIColor clearColor];
    [labelButton setTitle:@"Data  setting" forState:UIControlStateNormal];
    labelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    labelButton.titleLabel.textColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:labelButton];
    self.navigationItem.leftBarButtonItems = @[item,item1];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth - 200, 0, 150, 60)];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    
    _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth - 300, 0, 270, 60)];
    _emailLabel.textColor = [UIColor grayColor];
    _emailLabel.backgroundColor = [UIColor clearColor];
    _emailLabel.textAlignment = NSTextAlignmentRight;
    _emailLabel.font = [UIFont systemFontOfSize:14];
    
    [self addSubViews];
    [self refreshData];
    // Do any additional setup after loading the view.
}

- (void)addSubViews{
    _signoutButton = [[UIButton alloc] initWithFrame:CGRectMake(10, MainHeight - 64, MainWidth - 20, 50)];
    _signoutButton.backgroundColor = [UIColor  colorWithRed:28/255.0 green:128/255.0 blue:225/255.0 alpha:1];
    _signoutButton.layer.cornerRadius = 3.0;
    [_signoutButton setTitle:@"Sign out" forState:UIControlStateNormal];
    [_signoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_signoutButton addTarget:self action:@selector(signOut:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_signoutButton];
    
    
    _array = @[@"Modity Avatar", @"Account number", @"Nickname",@"Receiving address"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MainWidth, MainHeight - 128) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    [self.view addSubview:_tableView];
    
    UIButton *headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headImageButton.frame = CGRectMake(MainWidth - 10 - 70, 10, 50, 45);
    headImageButton.layer.cornerRadius = 25;
    headImageButton.clipsToBounds = YES;
    [headImageButton setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [headImageButton addTarget:self action:@selector(changeHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    _headImageButton = headImageButton;
    
    
}

- (void)signOut:(UIButton *)button{

    
    [_HTSET.loginModule loginOutFinish:^(BOOL loginOutSuccess) {
        
        if (loginOutSuccess == YES) {
            
            
            DBLoginViewController *login = [[DBLoginViewController alloc] init];
            
            [self.navigationController pushViewController:login animated:YES];
            
            
        }
      
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    cell.textLabel.text = _array[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (indexPath.row == 0) {
        [cell addSubview:_headImageButton];
    }else if (indexPath.row == 2){
    
        [cell addSubview:_nameLabel];
    }else if (indexPath.row == 1){
    
        [cell addSubview:_emailLabel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            [self changeHeadImage:nil];
            
        }
            break;
        case 1:{
        
            DBBindViewController *bind = [[DBBindViewController alloc] init];
            
            bind.changeNumberBlock = ^(NSString *number){
            
                _emailLabel.text = number;
            };
            
            [self.navigationController pushViewController:bind animated:YES];
        }
            break;
        case 2:{
            
            DBChangeInfoViewViewController *changeInfoVC = [[DBChangeInfoViewViewController alloc] init];
            
            changeInfoVC.changeNameBlock = ^(NSString *name){
                
                [self changeName:name];
            };
            
            [self.navigationController pushViewController:changeInfoVC animated:YES];
        }
            break;
        case 3:{
        
            DBAddressViewController *address = [[DBAddressViewController alloc] init];
            
            [self.navigationController pushViewController:address animated:YES];
        }
            break;
            
        default:
            break;
    }
}


//更改用户名称

- (void)changeName:(NSString *)name{

    [_HTSET.minModule changeUserName:name finish:^(id responseObject, NSError *error) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            id message = [responseObject objectForKey:@"message"];
            if ([message isEqualToString:@"success"]) {
                
                _nameLabel.text = name;
                
                 self.changeNameBlock ? self.changeNameBlock(_nameLabel.text):nil;
                
                [self showAlertViewWithMessage:@"更新成功"];
                
            }
        };
    }];
}

//上传照片
- (void)changeHeadImage:(UIButton *)button{

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择上传头像方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册获取",@"拍照", nil];
    [actionSheet showInView:self.navigationController.view];
}

#pragma mark - chosePhoto

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        [self imageFromAlbum];
    }
    else if (buttonIndex == 1){
    
        [self imageFromCamera];
    }
}

- (void)imageFromAlbum{

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
    
        [self showAlertViewWithMessage:@"当前设备不允许打开相册"];
    }
}

- (void)imageFromCamera{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
    
        [self showAlertViewWithMessage:@"当前设备不支持拍摄"];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *tempImg = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [self changeAvatarWithImage:tempImg];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//上传头像
- (void)changeAvatarWithImage:(UIImage *)image{

    [_HTSET.minModule changeHeadImageWithImage:image finish:^(id responseObject , NSError *error) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSString *message = [responseObject objectForKey:@"message"];
            
            if ([message isEqualToString:@"success"]) {
                
                [_headImageButton setImage:image forState:UIControlStateNormal];
                
                NSString *imageUrl =[NSString stringWithFormat:@"http://duobao.sysvi.cn/Public%@", [[responseObject objectForKey:@"data"] objectForKey:@"url"]];
        
                NSDictionary *parameter = @{@"avatar":imageUrl};
                
                 self.changeImageBlock ? self.changeImageBlock (image) : nil;
                
                [self updatePersionInfoWithParameter:parameter];
               
            }
        }
        
    }];
}

//修改个人信息
- (void)updatePersionInfoWithParameter:(NSDictionary *)parameter{

        [_HTSET.minModule updatePersionalInfoWithParameter:parameter finish:^(id responseObject, NSError *error) {
            
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                
                id message = [responseObject objectForKey:@"message"];
                
                if ([message isEqualToString:@"success"]) {
                    
                    [self refreshData];
                    
                    [self showAlertViewWithMessage:@"更新成功"];
                    
                }
            }
            
        }];
//

}

//根据token返回用户信息接口
- (void)refreshData{
    
    [_HTSET.minModule returnUserInformation:^(id responseObject,  NSError *error) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            id data = [responseObject objectForKey:@"data"];
            
            if (data && [data isKindOfClass:[NSDictionary class]]) {
                
                NSString *headImgStr = [[responseObject objectForKey:@"data"] objectForKey:@"avatar"];
                
                if (headImgStr && [headImgStr length] > 0) {
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                     NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:headImgStr]];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [_headImageButton setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                        });
                    });
                   
                }
                
                NSString *name = [data objectForKey:@"name"];
                if ([name isKindOfClass:[NSNull class]]) {
                    name = @"";
                    _nameLabel.text = nil;
                }
                _nameLabel.text = name;
                _emailLabel.text = [data objectForKey:@"email"];
               
                [self.tableView reloadData];
            }
        }
    }];

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
