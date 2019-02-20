//
//  RepoSRKModel.h
//  AS3
//
//  Created by zaka on 10/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "SharkORM.h"
#import "ReposModel.h"

@interface RepoSRKModel : SRKObject

@property NSString *owner;
@property NSString *full_name;
@property NSString *des;
@property NSString *avatar_url;

-(void)storeRepos:(NSMutableArray<ReposModel*>*)repos;

@end
