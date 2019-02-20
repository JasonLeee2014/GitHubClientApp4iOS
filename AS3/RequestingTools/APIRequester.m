//
//  APIRequester.m
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "APIRequester.h"

@implementation APIRequester

-(instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [APIManager manager];
    }
    return self;
}

- (void)startRequestWithSuccess:(responseBlock)responseBlock failure:(failureBlock)failureBlock{
    if (!self.enableCache) {
        [self.manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    }
    switch (self.method) {
        case APIManagerRequestMethodGET:{
            [self.manager GET:self.URL parameters:self.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                responseBlock(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(task,error);
            }];
            break;
        }
        case APIManagerRequestMethodPOST:{
            [self.manager POST:self.URL parameters:self.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                responseBlock(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(task,error);
            }];
            break;
        }
        case APIManagerRequestMethodPUT:{
            [self.manager PUT:self.URL parameters:self.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                responseBlock(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(task,error);
            }];
            break;
        }
        case APIManagerRequestMethodDELETE:{
            [self.manager DELETE:self.URL parameters:self.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                responseBlock(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(task,error);
            }];
            break;
        }
        default:
            break;
    }
}

-(BOOL)enableCache{
    return YES;
}

-(APIManagerRequestMethod)method{
    return APIManagerRequestMethodGET;
}

@end
