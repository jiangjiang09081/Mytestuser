//
//  DBFirstInViewController.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBFirstInViewController.h"
#import "DBUIObject.h"

@interface DBFirstInViewController ()

@end

@implementation DBFirstInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    // Do any additional setup after loading the view.
}

- (void)addSubViews{
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    mainScrollView.contentSize = CGSizeMake(MainWidth * 2, MainHeight);
    mainScrollView.pagingEnabled = YES;
    [self.view addSubview:mainScrollView];
    
    NSArray *imageArr;
//    if (IS_IPHONE_5) {
//        imageArr = @[@"5s.1",@"5s.2",@"5s.3"];
//    }
//    else if (IS_IPHONE_6){
//        imageArr = @[@"6.1",@"6.2",@"6.3"];
//    }
//    else if (IS_IPHONE_6_PLUS){
//        imageArr = @[@"6p1",@"6p2",@"6p3"];
//    }
//    else{
//        imageArr = @[@"4s.1",@"4s.2",@"4s.3"];
//    }
    imageArr = @[@"guide1",@"guide2"];
    for (int i = 0; i < [imageArr count]; i++) {
        NSString *str = [imageArr objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * MainWidth, 0, MainWidth, MainHeight)];
        imageView.image = [UIImage imageNamed:str];
        
        [mainScrollView addSubview:imageView];
        
        if (i == 1) {
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGestureReconginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [imageView addGestureRecognizer:tapGestureReconginzer];
        }
        
    }
}
- (void)tap:(UITapGestureRecognizer *)tap{
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"firstIn"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [_HTUI showMainWindow];
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
