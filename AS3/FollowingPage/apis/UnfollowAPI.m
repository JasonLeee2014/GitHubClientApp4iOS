//
//  UnfollowAPI.m
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "UnfollowAPI.h"

@implementation UnfollowAPI{
    NSString* _account;
}

-(id)initWithAccount:(NSString *)account{
    self = [super init];
    if (self) {
        _account = account;
    }
    return self;
}

-(NSString *)URL{
    return [NSString stringWithFormat:@"/user/following/%@",_account];
}

-(APIManagerRequestMethod)method{
    return APIManagerRequestMethodDELETE;
}

@end
