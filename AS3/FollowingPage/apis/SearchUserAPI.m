//
//  SearchUserAPI.m
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "SearchUserAPI.h"

@implementation SearchUserAPI{
    NSString* _qstring;
    NSInteger _page;
}

-(id)initWithSearchStr:(NSString *)qstring AndPage:(NSInteger)page{
    self = [super init];
    if (self) {
        _qstring = qstring;
        _page = page;
    }
    return self;
}

-(NSString *)URL{
    return @"/search/users";
}

-(NSDictionary *)params{
    NSDictionary * paramsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",_page],@"page",_qstring,@"q", nil];
    return paramsDictionary;
}

@end
