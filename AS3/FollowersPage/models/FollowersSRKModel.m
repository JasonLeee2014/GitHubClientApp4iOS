//
//  FollowersSRKModel.m
//  AS3
//
//  Created by zaka on 10/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "FollowersSRKModel.h"

@implementation FollowersSRKModel

@dynamic login,avatar_url;

-(void)storeFollowersData:(NSMutableArray<FollowersModel*>*)followersList{
    [[[[self class] query] fetch] removeAll];
    
    [SRKTransaction transaction:^{
        for (FollowersModel* item in followersList) {
            FollowersSRKModel* followersSRKModel = [FollowersSRKModel new];
            
            followersSRKModel.login = item.login;
            followersSRKModel.avatar_url = item.avatar_url;
            
            [followersSRKModel commit];
        }
    } withRollback:^{}];
}

@end
