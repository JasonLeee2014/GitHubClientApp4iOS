//
//  FollowersModel.h
//  AS3
//
//  Created by zaka on 09/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "JSONModel.h"

@interface FollowersModel : JSONModel

@property (nonatomic) NSString <Optional> *login;
@property (nonatomic) NSString <Optional> *avatar_url;

@end
