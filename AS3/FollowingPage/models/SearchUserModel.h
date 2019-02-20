//
//  SearchUserModel.h
//  AS3
//
//  Created by zaka on 10/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "JSONModel.h"

@protocol SingleUserModel;


@interface SingleUserModel : JSONModel

@property (nonatomic) NSString <Optional> *login;
@property (nonatomic) NSString <Optional> *avatar_url;

@end

@interface SearchUserModel : JSONModel

@property (nonatomic) NSArray <SingleUserModel> *items;

@end
