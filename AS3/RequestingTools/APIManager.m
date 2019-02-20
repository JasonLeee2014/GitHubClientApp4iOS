//
//  APIManager.m
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+(instancetype)manager{
    APIManager* manager = [super manager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    return manager;
}

-(NSURL *)baseURL{
    return [NSURL URLWithString:@"https://api.github.com"];
}

@end
