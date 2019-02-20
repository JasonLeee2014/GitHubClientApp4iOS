//
//  FollowersViewController.m
//  AS3
//
//  Created by zaka on 07/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "FollowingViewController.h"
#import "MJRefresh.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "FollowersModel.h"
#import "UserTableViewCell.h"
#import "ProfileViewController.h"
#import "FollowingSRKModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "GetAuthFollowingAPI.h"
#import "GetAccountFollowingAPI.h"

@interface FollowingViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *followingTableView;

@end

@implementation FollowingViewController{
    NSMutableArray * _dataSource;
    NSInteger current_page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializatioViews];
    // Do any additional setup after loading the view.
    [self theHeaderBeginToRefresh];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self theHeaderBeginToRefresh];
//}

- (void)initializatioViews
{
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.followingTableView];
    [self.followingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.height.and.right.equalTo(self.view);
    }];
}

- (UITableView *)followingTableView{
    if (!_followingTableView) {
        _followingTableView=[[UITableView alloc] init];
        _followingTableView.delegate=self;
        _followingTableView.dataSource=self;
        
        _followingTableView.emptyDataSetSource = self;
        _followingTableView.emptyDataSetDelegate = self;
        
        _followingTableView.tableFooterView = [UIView new];
        
        [_followingTableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
        _followingTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(theHeaderBeginToRefresh)];
        _followingTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(theFooterBeginToRefresh)];
    }
    return _followingTableView;
}

-(void)getAccountData:(NSInteger)page {
    [SVProgressHUD show];
    GetAccountFollowingAPI* api = [[GetAccountFollowingAPI alloc] initWithAccount:_account AndPage:page];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [_dataSource addObjectsFromArray:[FollowersModel arrayOfModelsFromDictionaries:responseObject error:nil]];
        
        [self.followingTableView reloadData];
        
        [self.followingTableView.mj_header endRefreshing];
        [self.followingTableView.mj_footer endRefreshing];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self.followingTableView.mj_header endRefreshing];
        [self.followingTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"ERROR"];
    }];
}

-(void)getData:(NSInteger)page {
    [SVProgressHUD show];
    GetAuthFollowingAPI* api = [[GetAuthFollowingAPI alloc] initWithPage:page];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [_dataSource addObjectsFromArray:[FollowersModel arrayOfModelsFromDictionaries:responseObject error:nil]];
        
        [self.followingTableView reloadData];
        
        [self.followingTableView.mj_header endRefreshing];
        [self.followingTableView.mj_footer endRefreshing];
        
        [[FollowingSRKModel new] storeFollowingData:_dataSource];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self.followingTableView.mj_header endRefreshing];
        [self.followingTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"ERROR"];
    }];
}

-(void)theHeaderBeginToRefresh{
    current_page=1;
    [_dataSource removeAllObjects];
    if (_account) {
        [self getAccountData:current_page];
    } else {
        [self getData:current_page];
    }
}

-(void)theFooterBeginToRefresh{
    current_page+=1;
    if (_account) {
        [self getAccountData:current_page];
    } else {
        [self getData:current_page];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setAvatar:((FollowersModel*)(_dataSource[indexPath.section])).avatar_url];
    [cell setUsername:((FollowersModel*)(_dataSource[indexPath.section])).login];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProfileViewController *vc =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Profile"];
    
    vc.username=((FollowersModel*)(_dataSource[indexPath.section])).login;

    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"nodata"];
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

