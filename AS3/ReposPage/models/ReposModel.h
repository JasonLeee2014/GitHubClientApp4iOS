//
//  ReposModel.h
//  AS3
//
//  Created by zaka on 07/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "JSONModel.h"

@interface ReposModel : JSONModel

@property (nonatomic) NSDictionary <Optional> *owner;
@property (nonatomic) NSString <Optional> *full_name;
@property (nonatomic) NSString <Optional> *des;
@property (nonatomic) NSString <Optional> *html_url;

@end
