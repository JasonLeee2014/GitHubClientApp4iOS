//
//  MyAnimatedTransitioning.h
//  AS3
//
//  Created by zaka on 14/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign) BOOL order;

@end
