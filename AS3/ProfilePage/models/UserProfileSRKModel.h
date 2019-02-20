//
//  UserProfileSRKModel.h
//  AS3
//
//  Created by zaka on 10/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "SharkORM.h"
#import "UserModel.h"

@interface UserProfileSRKModel : SRKObject

@property NSString* login;
@property NSString* avatar_url;
@property NSString* name;
@property NSString* email;
@property NSString* bio;
@property NSString* html_url;
@property NSInteger  public_repos;
@property NSInteger  followers;
@property NSInteger  following;
@property NSString* created_at;

-(void)storeUserProfile:(UserModel*)userModel;

@end
