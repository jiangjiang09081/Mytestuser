//
//  DBGoodSearchViewController.m
//  DBShopping
//
//  Created by jiang on 16/3/29.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBGoodSearchViewController.h"
#import "SearchTableViewCell.h"
static NSString *cellID = @"cellID";

@interface DBGoodSearchViewController ()<UISearchBarDelegate, UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UILabel *noDataLabel;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL hasNext;
@property (nonatomic, assign) BOOL isStore;

@property (nonatomic, strong) NSMutableArray *dataList;


@end

@implementation DBGoodSearchViewController

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
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
    self.view.backgroundColor = [UIColor whiteColor];
    _dataList = [NSMutableArray arrayWithCapacity:10];
    [self addSubViews];
      // Do any additional setup after loading the view.
}
//导航条搜索
- (void)addSubViews{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"backButton.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"searchwhite"] style:UIBarButtonItemStylePlain target:self action:@selector(SearchGoods)];
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 64)];
    _titleView.userInteractionEnabled = YES;
    _titleView.clipsToBounds = YES;
    self.navigationItem.titleView = _titleView;
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, MainWidth - 100, 45)];
    _searchTextField.font = [UIFont systemFontOfSize:14];
    _searchTextField.delegate = self;
    _searchTextField.textColor = [UIColor whiteColor];
    [_titleView addSubview:_searchTextField];
    
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(10, 40, MainWidth - 50, 1)];
    lineview.backgroundColor = [UIColor whiteColor];
    [_titleView addSubview:lineview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resign:)];
//    tap.delegate = self;
//    tap.numberOfTapsRequired = 2;
//    tap.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tap];
    
  
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MainWidth, MainHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:_tableView];

}
/**
 *  delegate
 *
 *  @return
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [cell setContentWithData:[_dataList objectAtIndex:indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

//刷新加载
- (void)refreshData{

    [_tableView setShowsInfiniteScrolling:NO];
    _page = 1;
    _isRefresh = YES;
    [_tableView.pullToRefreshView startAnimating];
  
    [self loadData];
    
}
//加载更多
- (void)loadMore{
    if (!_hasNext) {
        if ([_dataList count] > 0) {
            [_tableView.infiniteScrollingView noMoreData];
            
        }
    }
    else{
        _page ++;
        _isRefresh = NO;
        [_tableView.infiniteScrollingView startAnimating];
        [self loadData];
    }
    
}

- (void)back{
    
    [_dataList removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
}
//请求数据
- (void)loadData{
    
        [_HTSET.shoppingModule getSearchResultWithKeyWords:_searchTextField.text finish:^(id responseObject, NSError *error) {
            
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
               // _dataList = [responseObject objectForKey:@"data"];
                [self setResponseObjectWith:[responseObject objectForKey:@"data"]];
            }
            else{
                
                [_tableView.infiniteScrollingView stopAnimating];
            }
            if ([_dataList count] > 0) {
                [_tableView setShowsInfiniteScrolling:YES];
            }
            else{
                [_tableView setShowsInfiniteScrolling:NO];
            }
            [_tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:0.2];
            
        }];

}

- (void)setResponseObjectWith:(NSArray *)responseObject{

    if (_isRefresh) {
        [_tableView removeAlertView];
        
        [_dataList removeAllObjects];
     
    }
    if ([responseObject count] >= 15) {
        [_tableView.infiniteScrollingView setEnabled:YES];
        _hasNext = YES;
        [_tableView.infiniteScrollingView stopAnimating];
    }
    else{
        _hasNext = NO;
        [_tableView.infiniteScrollingView setEnabled:NO];
        if ([_dataList count] == 0) {
            [_tableView.infiniteScrollingView stopAnimating];
        }
        else{
            [_tableView.infiniteScrollingView noMoreData];
        }
    }
    [_dataList addObjectsFromArray:responseObject];
    
    [_tableView reloadData];
    
}
#pragma mark - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if ([_searchTextField.text length] == 0) {
        
        [self showAlertViewWithMessage:@"请输入商品名称"];
        return NO;
    }
    [_searchTextField resignFirstResponder];
    return YES;
}

- (void)resign:(UITapGestureRecognizer *)tap{
    
    [self.searchTextField resignFirstResponder];
    
}
- (void)SearchGoods{
    
    if ([_searchTextField.text isEqualToString:@""]) {
        [_tableView removeAllSubviews];
        [self.dataList removeAllObjects];
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (MainWidth - 64)/2 - 40, MainWidth, 40)];
        noDataLabel.font = [UIFont systemFontOfSize:16];
        noDataLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        noDataLabel.text = @"没有找到结果";
        _noDataLabel = noDataLabel;
        [self.view addSubview:_noDataLabel];
    }
    else{
        __weak typeof (self) weakSelf = self;
        [_tableView addPullToRefreshWithActionHandler:^{
            [weakSelf refreshData];
        }];
        
        [_tableView addInfiniteScrollingWithActionHandler:^{
            [weakSelf loadMore];
        }];
        [self.dataList removeAllObjects];
        _noDataLabel.text = @"";
        [self loadData];
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
