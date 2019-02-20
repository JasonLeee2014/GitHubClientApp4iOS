//
//  MyTabbarViewController.m
//  AS3
//
//  Created by zaka on 15/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "MyTabbarViewController.h"
#import "MyAnimatedTransitioning.h"

@interface MyTabbarViewController ()

@end

@implementation MyTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    MyAnimatedTransitioning* transitioning = [[MyAnimatedTransitioning alloc] init];
    if ([self.viewControllers indexOfObject:fromVC]>[self.viewControllers indexOfObject:toVC]) {
        transitioning.order = YES;
    } else {
        transitioning.order = NO;
    }
    
    return transitioning;
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
