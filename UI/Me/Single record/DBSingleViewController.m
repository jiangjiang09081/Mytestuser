//
//  DBSingleViewController.m
//  DBShopping
//
//  Created by jiang on 16/4/15.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBSingleViewController.h"
#import "TitleView.h"
#import "DBSingleTableViewCell.h"
#import "DBActivityModule.h"
#define TableViewTag 30

typedef enum TitleType{
    
    All = 0,
    Starting,
    Completed,
    
}TitleType;

static NSString *cellID = @"cellIDs";
@interface DBSingleViewController ()<TitleViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{

    NSInteger _page[4];
}
@property (nonatomic, strong) UIScrollView *bodyScrollView;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, strong) TitleView *titleView;

@end

@implementation DBSingleViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (NSArray *)dataSources{

    if (_dataSources == nil) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 30, 25)];
    [backButton setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *labelButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 150, 30)];
    labelButton.backgroundColor = [UIColor clearColor];
    [labelButton setTitle:@"Single record" forState:UIControlStateNormal];
    labelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    labelButton.titleLabel.textColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:labelButton];
    self.navigationItem.leftBarButtonItems = @[item,item1];
    
//    for (int i = 0; i < 3; i++) {
//        _page[i] = 1;
//    }
   
    [self createTitle];
    [self addSubViews];
    // Do any additional setup after loading the view.
}


- (void)createTitle{
    
    
    TitleView *titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 64, MainWidth, 60)];
    titleView.titles = @[@"All",@"Starting",@"Completed"];
   // titleView.delegate = self;
    _titleView = titleView;
    [self.view addSubview:_titleView];
}

#pragma mark titleViewDelegate
- (void)titleView:(TitleView *)view selectIndex:(NSInteger)index{

    //[self.bodyScrollView setContentOffset:CGPointMake((index * MainWidth), 0) animated:YES];
    
    //if ([self.dataSources[index] count] == 0) {
        
//        [self loadDataWithType:(TitleType)index];
    //}
    
}

- (void)addSubViews{

    _bodyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 128, MainWidth, MainHeight - 64)];
    _bodyScrollView.pagingEnabled = YES;
    _bodyScrollView.contentSize = CGSizeMake(3 * MainWidth, MainHeight);
    _bodyScrollView.delegate = self;
    [self.view addSubview:_bodyScrollView];
    
    //[self loadDataWithType:Starting];
    [self addTableView];
    
}

- (void)loadDataWithType:(TitleType)type{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"p":@(_page[type])}];
    NSArray *array = @[@" ",@"Starting",@"Completed"];
    [parameters setObject:array[type] forKey:@"type"];
    [_HTSET.activityModule getRegimentListWithType:[parameters objectForKey:@"type"] success:^(id responseObject, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
        }
    }];
    
    
    
}

- (void)addTableView{
    
    for (int i = 0; i < 3; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, self.bodyScrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = TableViewTag + i;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [tableView registerClass:[DBSingleTableViewCell class] forCellReuseIdentifier:cellID];
        [self.bodyScrollView addSubview:tableView];
    }
    
}

#pragma  mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;

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
