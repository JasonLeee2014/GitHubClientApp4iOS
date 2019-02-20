//
//  ProfileViewController.m
//  AS3
//
//  Created by zaka on 07/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "ProfileViewController.h"
#import <SVProgressHUD.h>
#import "UserModel.h"
#import "UIImageView+AFNetworking.h"
#import <Masonry.h>
#import "UserProfileSRKModel.h"
#import <SSBouncyButton.h>
#import <UIView+DCAnimationKit.h>
#import <UICountingLabel.h>
#import <TOMSMorphingLabel.h>
#import "ReposViewController.h"
#import "FollowingViewController.h"
#import "FollowersViewController.h"

#import "GetAuthUserAPI.h"
#import "GetAccountUserAPI.h"
#import "CheckStatusAPI.h"
#import "FollowAPI.h"
#import "UnfollowAPI.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController{
    UserModel* userModel;
    UIImageView * headerImg;
    UIBarButtonItem* followBtn;
    __weak IBOutlet UIImageView *avatarImage;
    __weak IBOutlet UILabel *name;
    __weak IBOutlet UILabel *githubName;
    __weak IBOutlet UICountingLabel *followersLbl;
    __weak IBOutlet UICountingLabel *followingLbl;
    __weak IBOutlet UILabel *websiteLbl;
    __weak IBOutlet UILabel *emailLbl;
    __weak IBOutlet UILabel *repoCntLbl;
    __weak IBOutlet TOMSMorphingLabel *bioLbl;
    __weak IBOutlet UILabel *creationDateLbl;
    __weak IBOutlet UIView *headerView;
    __weak IBOutlet UIButton *logoutBtn;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [avatarImage pulse:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    headerImg=[[UIImageView alloc] init];
    
    [avatarImage.layer setCornerRadius:45.0f];
    avatarImage.layer.masksToBounds = YES;
    
    followersLbl.format=@"%d FOLLOWERS";
    followingLbl.format=@"%d FOLLOWING";
    
    bioLbl.lineBreakMode = NSLineBreakByWordWrapping;
    bioLbl.numberOfLines = 0;
    bioLbl.animationDuration = 0.2;
    
    if (_username) {
        [self initDataWithAccount:_username];
        [logoutBtn setAlpha:0];
        [logoutBtn setEnabled:NO];
    } else {
        [self initData];
    }
    
    [headerView addSubview:headerImg];
    [headerView sendSubviewToBack:headerImg];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.and.right.equalTo(headerView);
    }];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [headerImg addSubview:blurView];
    [blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.and.right.equalTo(headerView);
    }];
    
    [self initNaviBarItem];
    
    
}

- (NSMutableArray*)slice:(NSString*)string{
    NSMutableArray *keywords = [[NSMutableArray alloc] init];
    CFStringTokenizerRef ref = CFStringTokenizerCreate(NULL, (__bridge CFStringRef)string, CFRangeMake(0, string.length), kCFStringTokenizerUnitWordBoundary, NULL);
    CFRange range;
    CFStringTokenizerAdvanceToNextToken(ref);
    range = CFStringTokenizerGetCurrentTokenRange(ref);
    NSString *keyWord;
    while (range.length>0) {
        keyWord = [string substringWithRange:NSMakeRange(range.location, range.length)];
        [keywords addObject:keyWord];
        CFStringTokenizerAdvanceToNextToken(ref);
        range = CFStringTokenizerGetCurrentTokenRange(ref);
    }
    CFRelease(ref);

    return keywords;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDataWithAccount:(NSString*)username{
    [SVProgressHUD show];
    
    GetAccountUserAPI* api = [[GetAccountUserAPI alloc] initWithAccountName:username];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        
        userModel = [[UserModel alloc] initWithDictionary:responseObject error:nil];
        [self showContent:userModel];
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"ERROR"];
    }];
}


- (void)initData{
    [SVProgressHUD show];
    
    GetAuthUserAPI* api = [[GetAuthUserAPI alloc] init];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        userModel = [[UserModel alloc] initWithDictionary:responseObject error:nil];
        
        [self showContent:userModel];
        [[UserProfileSRKModel new] storeUserProfile:userModel];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"ERROR"];
    }];
}

- (void)showContent:(UserModel*)userMNodel{
    [avatarImage setImageWithURL:[NSURL URLWithString:userModel.avatar_url]];
    name.text=userModel.name;
    githubName.text=userModel.login;
    [followersLbl countFromZeroTo:userModel.followers];
    [followingLbl countFromZeroTo:userModel.following];
    websiteLbl.text=userModel.html_url;
    emailLbl.text=userModel.email;
    repoCntLbl.text=[NSString stringWithFormat:@"%ld",userModel.public_repos];
    
    NSString* bio = userModel.bio?userModel.bio:@"Interesting, nothing here.";;
    [self setBioText:[self slice:bio]];
    
    NSDate* date =  [[[NSISO8601DateFormatter alloc] init] dateFromString:userModel.created_at];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    creationDateLbl.text=[dateFormatter stringFromDate:date];
    
    [headerImg setImageWithURL:[NSURL URLWithString:userModel.avatar_url]];
    
    [avatarImage pulse:NULL];
}

- (void)setBioText:(NSMutableArray*)words{
    [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSString* str = bioLbl.text;
        str = [NSString stringWithFormat:@"%@%@",str,words[0]];
        bioLbl.text=str;
        [words removeObjectAtIndex:0];
        if ([words count]==0) {
            [timer invalidate];
        }
    }];
}

- (void)initNaviBarItem{
    if (self.navigationController) {
        
        followBtn = [[UIBarButtonItem alloc] init];
        [followBtn setTarget:self];
        self.navigationItem.rightBarButtonItem = followBtn;
        
        [self checkStatus];
    }
}

- (void)setFollowBtnStatus:(BOOL)status{
    if (status) {
        SSBouncyButton *unforBtn = [[SSBouncyButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [unforBtn setTitle:@"Unfollow" forState:UIControlStateSelected];
        [unforBtn setSelected:YES];
        [unforBtn addTarget:self action:@selector(unfollow) forControlEvents:UIControlEventTouchUpInside];
        [followBtn setCustomView:unforBtn];
    } else {
        SSBouncyButton *forBtn = [[SSBouncyButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [forBtn setTitle:@"Follow" forState:UIControlStateNormal];
        [forBtn setSelected:NO];
        [forBtn addTarget:self action:@selector(follow) forControlEvents:UIControlEventTouchUpInside];
        [followBtn setCustomView:forBtn];
    }
}

-(void)checkStatus{
    CheckStatusAPI* api = [[CheckStatusAPI alloc] initWithAccountName:_username];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [self setFollowBtnStatus:YES];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self setFollowBtnStatus:NO];
    }];
}

-(void)follow{
    [SVProgressHUD show];
    
    FollowAPI *api =[[FollowAPI alloc] initWithAccount:_username];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [self setFollowBtnStatus:YES];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"error"];
    }];
    
}

-(void)unfollow{
    [SVProgressHUD show];
    UnfollowAPI* api = [[UnfollowAPI alloc] initWithAccount:_username];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        [self setFollowBtnStatus:NO];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"error"];
    }];
}

- (IBAction)logout:(id)sender {
    NSUserDefaults * store =[NSUserDefaults standardUserDefaults];
    [store removeObjectForKey:@"token"];
    
    [[[UIApplication sharedApplication] delegate] window].rootViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];

}

- (IBAction)naviToRepo:(id)sender {
    if (self.navigationController) {
        ReposViewController * vc = [[ReposViewController alloc] init];
        vc.account = _username;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.tabBarController setSelectedIndex:1];
    }
}

- (IBAction)naviToFollowers:(id)sender {
    if (self.navigationController) {
        FollowersViewController* vc = [[FollowersViewController alloc] init];
        vc.account = _username;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.tabBarController setSelectedIndex:2];
    }
}

- (IBAction)naviToFollowing:(id)sender {
    if (self.navigationController) {
        FollowingViewController* vc = [[FollowingViewController alloc] init];
        vc.account = _username;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.tabBarController setSelectedIndex:3];
    }
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
