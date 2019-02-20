//
//  ReposViewController.m
//  AS3
//
//  Created by zaka on 07/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "MyStarViewController.h"
#import "ReposTableViewCell.h"
#import "ReposModel.h"
#import "MJRefresh.h"
#import "UIImageView+AFNetworking.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "StarViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "GetStaredReposAPI.h"

@interface  MyStarViewController() <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *reposTableView;

@end

@implementation MyStarViewController{
    NSMutableArray * _dataSource;
    NSInteger current_page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializatioViews];
    
    [self theHeaderBeginToRefresh];
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self theHeaderBeginToRefresh];
//}

-(void)fetchData:(NSInteger)page {
    [SVProgressHUD show];
    GetStaredReposAPI *api = [[GetStaredReposAPI alloc] initWithPage:page];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [_dataSource addObjectsFromArray:[ReposModel arrayOfModelsFromDictionaries:responseObject error:nil]];
        
        
        [_reposTableView reloadData];
        
        [_reposTableView.mj_header endRefreshing];
        [_reposTableView.mj_footer endRefreshing];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [_reposTableView.mj_header endRefreshing];
        [_reposTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"ERROR"];
    }];
}

-(void)theHeaderBeginToRefresh{
    current_page=1;
    [_dataSource removeAllObjects];
    [self fetchData:current_page];
}

-(void)theFooterBeginToRefresh{
    current_page+=1;
    [self fetchData:current_page];
}

- (void)initializatioViews
{
    _dataSource = [NSMutableArray array];
    _reposTableView=[self reposTableView];
    
    [self.view addSubview:_reposTableView];
    [_reposTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    ReposTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.owener.text =((ReposModel*)(_dataSource[indexPath.section])).owner[@"login"];
    cell.RepoName.text=((ReposModel*)(_dataSource[indexPath.section])).full_name;
    cell.des.text=((ReposModel*)(_dataSource[indexPath.section])).des?((ReposModel*)(_dataSource[indexPath.section])).des:@"No description yet.";
    [cell.avatar setImageWithURL:[NSURL URLWithString:((ReposModel*)(_dataSource[indexPath.section])).owner[@"avatar_url"]]];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString* url = ((ReposModel*)(_dataSource[indexPath.section])).html_url;
    //    SFSafariViewController* vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    StarViewController* vc=[[StarViewController alloc] init];
    vc.url=url;
    vc.fullname=((ReposModel*)(_dataSource[indexPath.section])).full_name;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableView *)reposTableView{
    if (!_reposTableView) {
        _reposTableView=[[UITableView alloc] init];
        _reposTableView.delegate=self;
        _reposTableView.dataSource=self;
        
        _reposTableView.emptyDataSetSource = self;
        _reposTableView.emptyDataSetDelegate = self;
        
        _reposTableView.tableFooterView = [UIView new];
        
        _reposTableView.estimatedRowHeight=100;
        
        [_reposTableView registerNib:[UINib nibWithNibName:@"ReposTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
        _reposTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(theHeaderBeginToRefresh)];
        _reposTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(theFooterBeginToRefresh)];
    }
    return _reposTableView;
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


