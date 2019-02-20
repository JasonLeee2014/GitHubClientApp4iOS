//
//  ReposViewController.m
//  AS3
//
//  Created by zaka on 07/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "AllUsersViewController.h"
#import "UserTableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+AFNetworking.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "StarViewController.h"
#import "SearchUserModel.h"
#import "UserTableViewCell.h"
#import "ProfileViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "SearchUserAPI.h"

@interface AllUsersViewController () <UITableViewDelegate, UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *usersTableView;

@property (nonatomic,retain) UISearchController *searchController;

@end

@implementation AllUsersViewController{
    NSMutableArray * _dataSource;
    NSInteger current_page;
    NSString* lastSearchText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializatioViews];
    self.definesPresentationContext = YES;
    current_page=1;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchController dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchData:(NSString*)qstring page:(NSInteger)page {
    [SVProgressHUD show];
    SearchUserAPI* api = [[SearchUserAPI alloc] initWithSearchStr:qstring AndPage:page];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        if (page==1) {
            [_dataSource removeAllObjects];
        }
        
        [_dataSource addObjectsFromArray:[[SearchUserModel alloc] initWithDictionary:responseObject error:nil].items];
        
        
        [self.usersTableView reloadData];
        
        [self.usersTableView.mj_footer endRefreshing];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self.usersTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"ERROR"];
    }];
}

-(void)theFooterBeginToRefresh{
    current_page+=1;
    [self searchData:_searchController.searchBar.text page:current_page];
}

- (void)initializatioViews
{
    _dataSource = [NSMutableArray array];
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.delegate=self;
    _searchController.searchResultsUpdater=self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(0, 0, self.searchController.searchBar.frame.size.width, 44.0);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.searchController.searchBar.frame.size.width, 44.0)];
    [view addSubview:_searchController.searchBar];
    
    self.usersTableView.tableHeaderView = view;
    
    [self.view addSubview:self.usersTableView];
    [self.usersTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.height.and.right.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [cell setAvatar:((SingleUserModel*)(_dataSource[indexPath.section])).avatar_url];
    [cell setUsername:((SingleUserModel*)(_dataSource[indexPath.section])).login];
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
    
    vc.username=((SingleUserModel*)(_dataSource[indexPath.section])).login;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableView *)usersTableView{
    if (!_usersTableView) {
        _usersTableView=[[UITableView alloc] init];
        _usersTableView.delegate=self;
        _usersTableView.dataSource=self;
        
        _usersTableView.emptyDataSetSource = self;
        _usersTableView.emptyDataSetDelegate = self;
        
        _usersTableView.tableFooterView = [UIView new];
        
        [_usersTableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
        _usersTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(theFooterBeginToRefresh)];
    }
    return _usersTableView;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if(![searchController.searchBar.text isEqualToString:@""]&&![lastSearchText isEqualToString:searchController.searchBar.text]){
        current_page=1;
        lastSearchText=searchController.searchBar.text;
        [self searchData:searchController.searchBar.text page:current_page];
    }
}

-(void)didDismissSearchController:(UISearchController *)searchController{
    [_dataSource removeAllObjects];
    [self.usersTableView reloadData];
}


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


