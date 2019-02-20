
//
//  GetAuthFollowingAPI.m
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "GetAuthFollowingAPI.h"

@implementation GetAuthFollowingAPI{
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
    return @"/user/following";
}

-(NSDictionary *)params{
    NSDictionary * paramsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",_page],@"page", nil];
    return paramsDictionary;
}

-(BOOL)enableCache{
    return NO;
}

@end
