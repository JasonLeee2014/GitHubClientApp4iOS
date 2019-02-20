//
//  LoginAPI.m
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "LoginAPI.h"

@implementation LoginAPI{
    NSString* _username;
    NSString* _password;
}

-(id)initWithUsername:(NSString*)username AndPassword:(NSString*)password{
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        NSString* base64str = [self base64EncodedString:[NSString stringWithFormat:@"%@:%@",username,password]];
        [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"Basic %@",base64str] forHTTPHeaderField:@"Authorization"];
    }
    return self;
}

-(NSString *)URL{
    return @"/authorizations";
}

-(NSDictionary *)params{
    NSDictionary *parametersDictionary = @{@"client_id": @"037997ee24528064fed7",@"client_secret": @"71196b4c146382b7e7545ceef828c2b73979fa13", @"scopes": @[@"public_repo", @"user:follow"]};
    return parametersDictionary;
}

-(APIManagerRequestMethod)method{
    return APIManagerRequestMethodPOST;
}

- (NSString *)base64EncodedString:(NSString*)str;
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}


@end
