//
//  GetAuthReposAPI.m
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "GetAuthReposAPI.h"

@implementation GetAuthReposAPI{
    NSInteger _page;
}

-(id)initWithPage:(NSInteger)page{
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}

-(NSString *)URL{
    return @"/user/repos";
}

-(NSDictionary *)params{
    NSDictionary * paramsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"all",@"type",[NSString stringWithFormat:@"%ld",_page],@"page", nil];
    return paramsDictionary;
}

@end
