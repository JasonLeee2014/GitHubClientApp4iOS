//
//  LoginViewController.m
//  AS3
//
//  Created by zaka on 08/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TokenModel.h"
#import <SVProgressHUD.h>

#import "LoginAPI.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    __weak IBOutlet UITextField *_userNameField;
    __weak IBOutlet UITextField *_passWordField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getToken:(NSString *)username password:(NSString* )password{
    [SVProgressHUD show];
    LoginAPI* api = [[LoginAPI alloc] initWithUsername:username AndPassword:password];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        TokenModel *tokenModel = [[TokenModel alloc] initWithDictionary:responseObject error:nil];
        if (tokenModel.token) {
            [tokenModel saveToken];
            
            [SVProgressHUD dismiss];
            [[[UIApplication sharedApplication] delegate] window].rootViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"ERROR"];
    }];
}

- (IBAction)login:(id)sender {
    NSString* username = _userNameField.text;
    NSString* password = _passWordField.text;
    
    [self getToken:username password:password];
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
