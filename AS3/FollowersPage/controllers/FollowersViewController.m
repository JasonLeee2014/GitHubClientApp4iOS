//
//  FollowersViewController.m
//  AS3
//
//  Created by zaka on 07/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "FollowersViewController.h"
#import "MJRefresh.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "FollowersModel.h"
#import "UserTableViewCell.h"
#import "ProfileViewController.h"
#import "FollowersSRKModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "GetAuthFollowersAPI.h"
#import "GetAccountFollowersAPI.h"

@interface FollowersViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *followersTableView;

@end

@implementation FollowersViewController{
    NSMutableArray * _dataSource;
    NSInteger current_page;
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self theHeaderBeginToRefresh];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializatioViews];
    // Do any additional setup after loading the view.
    [self theHeaderBeginToRefresh];
}

- (void)initializatioViews
{
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.followersTableView];
    [self.followersTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.height.and.right.equalTo(self.view);
    }];
}

- (UITableView *)followersTableView{
    if (!_followersTableView) {
        _followersTableView=[[UITableView alloc] init];
        _followersTableView.delegate=self;
        _followersTableView.dataSource=self;
        
        _followersTableView.emptyDataSetSource = self;
        _followersTableView.emptyDataSetDelegate = self;
        
        _followersTableView.tableFooterView = [UIView new];
        
        [_followersTableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
        _followersTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(theHeaderBeginToRefresh)];
        _followersTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(theFooterBeginToRefresh)];
    }
    return _followersTableView;
}

-(void)getAccountData:(NSInteger)page {
    [SVProgressHUD show];
    GetAccountFollowersAPI* api = [[GetAccountFollowersAPI alloc] initWithAccount:_account AndPage:page];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [_dataSource addObjectsFromArray:[FollowersModel arrayOfModelsFromDictionaries:responseObject error:nil]];
        
        [self.followersTableView reloadData];
        
        [self.followersTableView.mj_header endRefreshing];
        [self.followersTableView.mj_footer endRefreshing];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self.followersTableView.mj_header endRefreshing];
        [self.followersTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"ERROR"];
    }];
}

-(void)getData:(NSInteger)page {
    [SVProgressHUD show];
    GetAuthFollowersAPI* api = [[GetAuthFollowersAPI alloc] initWithPage:page];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [_dataSource addObjectsFromArray:[FollowersModel arrayOfModelsFromDictionaries:responseObject error:nil]];
        
        [self.followersTableView reloadData];
        
        [self.followersTableView.mj_header endRefreshing];
        [self.followersTableView.mj_footer endRefreshing];
        
        [[FollowersSRKModel new] storeFollowersData:_dataSource];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self.followersTableView.mj_header endRefreshing];
        [self.followersTableView.mj_footer endRefreshing];
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
