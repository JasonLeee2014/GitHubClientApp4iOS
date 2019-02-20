//
//  FollowSRKModel.m
//  AS3
//
//  Created by zaka on 10/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "FollowingSRKModel.h"

@implementation FollowingSRKModel

@dynamic login,avatar_url;

-(void)storeFollowingData:(NSMutableArray<FollowersModel*>*)followingList{
    [[[[self class] query] fetch] removeAll];
    
    [SRKTransaction transaction:^{
        for (FollowersModel* item in followingList) {
            FollowingSRKModel* followoingSRKModel = [FollowingSRKModel new];
            
            followoingSRKModel.login = item.login;
            followoingSRKModel.avatar_url = item.avatar_url;
            
            [followoingSRKModel commit];
        }
    } withRollback:^{}];
}

@end
