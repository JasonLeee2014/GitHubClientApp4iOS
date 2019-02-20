//
//  RepoSRKModel.m
//  AS3
//
//  Created by zaka on 10/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "RepoSRKModel.h"

@implementation RepoSRKModel

@dynamic owner,full_name,des,avatar_url;

-(void)storeRepos:(NSMutableArray<ReposModel*>*)repos{
    [[[[self class] query] fetch] removeAll];
    [SRKTransaction transaction:^{
        for (ReposModel* item in repos) {
            RepoSRKModel* repoSRKModel = [RepoSRKModel new];
            repoSRKModel.owner = item.owner[@"login"];
            repoSRKModel.full_name = item.full_name;
            repoSRKModel.des = item.des;
            repoSRKModel.avatar_url = item.owner[@"avatar_url"];
            
            [repoSRKModel commit];
        }
    } withRollback:^{}];
}

@end
