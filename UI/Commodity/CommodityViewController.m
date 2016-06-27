//
//  CommodityViewController.m
//  DBShopping
//
//  Created by jiang on 16/3/25.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "CommodityViewController.h"
#import "DBCommodityModule.h"
#import "DBGoodSearchViewController.h"
#import "DBDetileViewController.h"
#import "SDCycleScrollView.h"
#import "TitleView.h"
#import "BLBaseUIHelper.h"
#import "CommodityTableViewCell.h"
#import "DBGoodSearchViewController.h"


#define TableViewTag  50
#define SDScrollViewTag 60
typedef enum titleType{

    Hot = 0,
    News,
    Complete,
    Atfirst,
}TitleType;

static NSString *cellID = @"cellID";

@interface CommodityViewController ()<TitleViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{

    NSInteger _page[4];
}

@property (nonatomic, strong) UIScrollView *bodyScrollView;
@property (nonatomic, strong) TitleView *titleView;

@property (nonatomic, strong) NSMutableArray *dataSourse;
@property (nonatomic, strong) NSArray *sliderArr;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic) CGFloat height;

@end

@implementation CommodityViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.translucent = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Commodity" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"searchwhite"] style:UIBarButtonItemStylePlain target:self action:@selector(SearchGood)];
    
    for (int i = 0; i < 4; i++) {
        _page[i] = 1;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadDataWithType:Hot];
    
    [self createTitle];
    [self createScrollView];
  
    // Do any additional setup after loading the view.
}

- (void)createTitle{
    
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 64, MainWidth, 44)];
    titleView.titles = @[@"Hot",@"News",@"Complete",@"At first"];
    titleView.delegate = self;
    self.titleView = titleView;
    [self.view addSubview:titleView];
   
}

- (void)createScrollView{
    
    self.bodyScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, MainWidth , MainHeight - 108 - 44)];
    self.bodyScrollView.delegate = self;
    self.bodyScrollView.pagingEnabled = YES;
    self.bodyScrollView.contentSize = CGSizeMake(self.bodyScrollView.frame.size.width * 4, self.bodyScrollView.frame.size.height);
    
    [self.view addSubview:self.bodyScrollView];
    
    [self getDataFromNetWork];
}

//获取头视图
- (void)getDataFromNetWork{
    
    [_HTSET.shoppingModule getMobileSlide:^(id responseObject, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.sliderArr = [responseObject objectForKey:@"data"];
        }
        
        [self setContent];
    }];
    
    
}

//显示头视图
- (void)setContent{
    _height = 0;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:10];
    
    for (NSDictionary *dic in _sliderArr) {
        
        if ([[dic objectForKey:@"img"] length] > 0) {
            NSString *img = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"Public%@",[dic objectForKey:@"img"]]];
            [images addObject:img];
            _images = images;
        }
    }

     [self createTableView];
}
//滚动栏点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

  
}

//创建每个tableView
- (void)createTableView{

    self.dataSourse = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        [self.dataSourse addObject:models];
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i * MainWidth, 0, MainWidth, self.bodyScrollView.frame.size.height ) style:UITableViewStylePlain];
        tableView.tag = i + TableViewTag;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        if ([_images count] > 0) {
            
            SDCycleScrollView  *sdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(i *MainWidth, 0, MainWidth, 140) imagesGroup:_images];
            
            sdScrollView.tag = i + SDScrollViewTag;
            sdScrollView.delegate = self;
            sdScrollView.autoScrollTimeInterval = 5.0;
            tableView.tableHeaderView = sdScrollView;
        }
        
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [tableView registerClass:[CommodityTableViewCell class] forCellReuseIdentifier:cellID];
        
        [self.bodyScrollView addSubview:tableView];
        
    }
}

//刷新视图
- (void)refreshData:(NSInteger)I{
    
    [[WrappedHUDHelper sharedHelper]showHUDInView:self.view withTitle:@"正在加载"];
    
    UITableView *tableView = [self.bodyScrollView viewWithTag:I + TableViewTag];
    
    [tableView.pullToRefreshView startAnimating];
    
    [self loadDataWithType:(TitleType)(I)];
}

#pragma mark 网络请求
- (void)loadDataWithType:(TitleType)type{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:@{@"p":@(_page[type])}];
    
    NSArray *types = @[@"hot",@"new",@"complete",@"history"];
    
    [parameter setObject:types[type] forKey:@"type"];
    
    [_HTSET.commodityModule getRegimentListWithType:[parameter objectForKey:@"type"] success:^(id responseObject, NSError *error) {
       
        [[WrappedHUDHelper sharedHelper]hideHUD];
        
        UITableView *tableView = [self.bodyScrollView viewWithTag:type +TableViewTag];
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self.dataSourse[type] addObjectsFromArray:[responseObject objectForKey:@"data"]];
            
            [tableView reloadData];
        }

    }];
}

- (void)titleView:(TitleView *)view selectIndex:(NSInteger)index{
    
    [self.bodyScrollView setContentOffset:CGPointMake(index * MainWidth, 0) animated:YES];
    
    if ([self.dataSourse[index] count] == 0) {
        
        [self loadDataWithType:(TitleType)index];
    }
}

//搜索
- (void)SearchGood{
    
    DBGoodSearchViewController *dv = [[DBGoodSearchViewController alloc]init];
    [self.navigationController pushViewController:dv animated:YES];
    
}

#pragma mark delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.bodyScrollView == scrollView) {
        NSInteger index = self.bodyScrollView.contentOffset.x/self.bodyScrollView.frame.size.width;
        //点击对应button
        [self.titleView clickButton:self.titleView.buttons[index]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSourse[tableView.tag - TableViewTag]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommodityTableViewCell *cell = (CommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CommodityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setContentWithData:[self.dataSourse[tableView.tag - TableViewTag] objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *data = _dataSourse[tableView.tag - TableViewTag][indexPath.row];
    DBDetileViewController *detailVc = [[DBDetileViewController alloc]init];
    detailVc.goods_ID = [[data objectForKey:@"goods"] objectForKey:@"goods_id"];
    detailVc.needs = [[data objectForKey:@"ac"] objectForKey:@"term_auto" ];
    detailVc.only = [[data objectForKey:@"ac"]objectForKey:@"term_num"];
    [self.navigationController pushViewController:detailVc animated:YES];
    
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
