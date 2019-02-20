//
//  UnStarAPI.m
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "UnStarAPI.h"

@implementation UnStarAPI{
    NSString* _fullname;
}

-(id)initWithFullname:(NSString*)fullname{
    self = [super init];
    if (self) {
        _fullname = fullname;
    }
    return self;
}

-(NSString *)URL{
    return [NSString stringWithFormat:@"/user/starred/%@",_fullname];
}

-(APIManagerRequestMethod)method{
    return APIManagerRequestMethodDELETE;
}

@end
