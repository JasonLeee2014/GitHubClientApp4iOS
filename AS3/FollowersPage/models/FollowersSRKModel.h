//
//  FollowersSRKModel.h
//  AS3
//
//  Created by zaka on 10/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "SharkORM.h"
#import "FollowersModel.h"

@interface FollowersSRKModel : SRKObject

@property NSString* login;
@property NSString* avatar_url;

-(void)storeFollowersData:(NSMutableArray<FollowersModel*>*)followersList;

@end
