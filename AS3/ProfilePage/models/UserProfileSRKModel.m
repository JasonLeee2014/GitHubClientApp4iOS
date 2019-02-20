//
//  UserProfileSRKModel.m
//  AS3
//
//  Created by zaka on 10/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "UserProfileSRKModel.h"

@implementation UserProfileSRKModel

@dynamic login,avatar_url,name,email,bio,html_url,public_repos,followers,following,created_at;

-(void)storeUserProfile:(UserModel*)userModel{
    [[[[self class] query] fetch] removeAll]; //delete last inserted data;
    
    self.login = userModel.login;
    self.name = userModel.name;
    self.avatar_url = userModel.avatar_url;
    self.followers = userModel.followers;
    self.following = userModel.following;
    self.html_url = userModel.html_url;
    self.email = userModel.email;
    self.public_repos = userModel.public_repos;
    self.bio = userModel.bio;
    self.created_at = userModel.created_at;
    
    [self commit];
}

@end
