//
//  StarViewController.m
//  AS3
//
//  Created by zaka on 09/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "StarViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>
#import <SVProgressHUD.h>
#import <SSBouncyButton.h>

#import "CheckStarStatusAPI.h"
#import "StarAPI.h"
#import "UnStarAPI.h"

@interface StarViewController ()

@end

@implementation StarViewController{
    UIBarButtonItem* btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebView* webView = [[WKWebView alloc] init];
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.and.bottom.equalTo(self.view);
    }];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
    btn =[[UIBarButtonItem alloc] init];
    [btn setTarget:self];
    self.navigationItem.rightBarButtonItem = btn;
    
    [self setTitle:_fullname];
    
    [self checkStatus];
    
    
}

-(void)setStarBtnState:(BOOL)status{
    if (status) {
        SSBouncyButton *unstarBtn = [[SSBouncyButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [unstarBtn setTitle:@"Unstar" forState:UIControlStateSelected];
        [unstarBtn setSelected:YES];
        [unstarBtn addTarget:self action:@selector(unstar) forControlEvents:UIControlEventTouchUpInside];
        [btn setCustomView:unstarBtn];
    } else {
        SSBouncyButton *starBtn = [[SSBouncyButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [starBtn setTitle:@"Star" forState:UIControlStateNormal];
        [starBtn setSelected:NO];
        [starBtn addTarget:self action:@selector(star) forControlEvents:UIControlEventTouchUpInside];
        [btn setCustomView:starBtn];
    }
}

-(void)checkStatus{
    CheckStarStatusAPI *api = [[CheckStarStatusAPI alloc] initWithFullname:_fullname];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [self setStarBtnState:YES];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self setStarBtnState:NO];
    }];
}

-(void)star{
    [SVProgressHUD show];
    StarAPI* api = [[StarAPI alloc] initWithFullname:_fullname];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [self setStarBtnState:YES];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"error"];
    }];
}

-(void)unstar{
    [SVProgressHUD show];
    UnStarAPI* api = [[UnStarAPI alloc] initWithFullname:_fullname];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [self setStarBtnState:NO];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"error"];
    }];
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
