//
//  APIRequester.h
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"

typedef void (^responseBlock)(NSURLSessionTask *task, id responseObject);
typedef void (^failureBlock)(NSURLSessionTask *operation, NSError *error);

typedef enum
{
    APIManagerRequestMethodGET = 0,
    APIManagerRequestMethodPOST,
    APIManagerRequestMethodPUT,
    APIManagerRequestMethodDELETE,
} APIManagerRequestMethod;

@interface APIRequester : NSObject

@property NSString* URL;
@property NSDictionary* params;
@property APIManager* manager;
@property(nonatomic) BOOL enableCache;
@property(nonatomic) APIManagerRequestMethod method;


- (void)startRequestWithSuccess:(responseBlock)responseBlock failure:(failureBlock)failureBlock;

@end
