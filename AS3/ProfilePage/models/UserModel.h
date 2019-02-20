//
//  UserModel.h
//  AS3
//
//  Created by zaka on 07/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "JSONModel.h"

@interface UserModel : JSONModel

@property (nonatomic) NSString <Optional> *login;
@property (nonatomic) NSString <Optional> *avatar_url;
@property (nonatomic) NSString <Optional> *name;
@property (nonatomic) NSString <Optional> *email;
@property (nonatomic) NSString <Optional> *bio;
@property (nonatomic) NSString <Optional> *html_url;
@property (nonatomic) NSInteger  public_repos;
@property (nonatomic) NSInteger  public_gists;
@property (nonatomic) NSInteger  followers;
@property (nonatomic) NSInteger  following;
@property (nonatomic) NSString <Optional> *created_at;

@end
