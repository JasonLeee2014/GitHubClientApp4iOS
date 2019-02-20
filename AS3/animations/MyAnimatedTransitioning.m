//
//  MyAnimatedTransitioning.m
//  AS3
//
//  Created by zaka on 14/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "MyAnimatedTransitioning.h"

@implementation MyAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView* containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [containerView setBackgroundColor:[UIColor whiteColor]];
    [containerView addSubview:toViewController.view];
    CGFloat viewWidth = CGRectGetWidth(toViewController.view.bounds);
    if (_order) {
        viewWidth = -viewWidth;
    }
    
    toViewController.view.transform = CGAffineTransformMakeTranslation(viewWidth, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toViewController.view.transform = CGAffineTransformIdentity;
        fromViewController.view.transform = CGAffineTransformMakeTranslation(-viewWidth, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        fromViewController.view.transform = CGAffineTransformIdentity;
    }];

}

@end
