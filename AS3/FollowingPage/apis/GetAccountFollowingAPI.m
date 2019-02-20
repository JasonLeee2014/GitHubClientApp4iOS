//
//  GetAccountFollowingAPI.m
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "GetAccountFollowingAPI.h"

@implementation GetAccountFollowingAPI{
    NSString* _account;
    NSInteger _page;
}

-(id)initWithAccount:(NSString*)account AndPage:(NSInteger)page{
    self = [super init];
    if (self) {
        _account = account;
        _page = page;
    }
    return self;
}

-(NSString *)URL{
    return [NSString stringWithFormat:@"/users/%@/following",_account];
}

-(NSDictionary *)params{
    NSDictionary * paramsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",_page],@"page", nil];
    return paramsDictionary;
}

@end
