//
//  ReposAPITest.m
//  RequestTests
//
//  Created by zaka on 17/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RequestBaseTest.h"
#import "GetAuthReposAPI.h"
#import "GetAccountReposAPI.h"
#import "SearchReposAPI.h"
#import "GetStaredReposAPI.h"


@interface ReposAPITest : RequestBaseTest

@end

@implementation ReposAPITest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetAuthReposAPI {
    GetAuthReposAPI *api = [[GetAuthReposAPI alloc] init];
    [self check:api SuccessCode:200 FailedMsg:@"GetAuthReposAPI test failed"];
}

- (void)testGetAccountReposAPI {
    GetAccountReposAPI *api = [[GetAccountReposAPI alloc] initWithAccount:self.testAccount AndPage:1];
    [self check:api SuccessCode:200 FailedMsg:@"GetAccountReposAPI test failed"];
}

- (void)testGetAccountReposAPIWithWrongInfo {
    GetAccountReposAPI *api = [[GetAccountReposAPI alloc] initWithAccount:self.testWrongInfo AndPage:1];
    [self checkWrongInfo:api FailureCode:404 FailedMsg:@"GetAccountReposAPI test failed"];
}

- (void)testSearchReposAPI {
    SearchReposAPI *api = [[SearchReposAPI alloc] initWithSearchStr:self.qstring AndPage:1];
    [self check:api SuccessCode:200 FailedMsg:@"SearchReposAPI test failed"];
}

- (void)testGetStaredReposAPI {
    GetStaredReposAPI * api = [[GetStaredReposAPI alloc] initWithPage:1];
    [self check:api SuccessCode:200 FailedMsg:@"GetStaredReposAPI test failed"];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
