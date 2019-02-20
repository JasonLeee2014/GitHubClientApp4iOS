//
//  FollowAPITest.m
//  RequestTests
//
//  Created by zaka on 17/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RequestBaseTest.h"
#import "GetAuthFollowersAPI.h"
#import "GetAccountFollowersAPI.h"
#import "GetAuthFollowingAPI.h"
#import "GetAccountFollowingAPI.h"
#import "SearchUserAPI.h"

@interface FollowAPITest : RequestBaseTest

@end

@implementation FollowAPITest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetAuthFollowersAPI {
    GetAuthFollowersAPI * api = [[GetAuthFollowersAPI alloc] initWithPage:1];
    [self check:api SuccessCode:200 FailedMsg:@"GetAuthFollowersAPI test failed"];
}

- (void)testGetAccountFollowersAPI {
    GetAccountFollowersAPI * api = [[GetAccountFollowersAPI alloc] initWithAccount:self.testAccount AndPage:1];
    [self check:api SuccessCode:200 FailedMsg:@"GetAccountFollowersAPI test failed"];
}

- (void)testGetAccountFollowersAPIWithWrongInfo {
    GetAccountFollowersAPI * api = [[GetAccountFollowersAPI alloc] initWithAccount:self.testWrongInfo AndPage:1];
    [self checkWrongInfo:api FailureCode:404 FailedMsg:@"GetAccountFollowersAPI test failed"];
}

- (void)testGetAuthFollowingAPI {
    GetAuthFollowingAPI * api = [[GetAuthFollowingAPI alloc] initWithPage:1];
    [self check:api SuccessCode:200 FailedMsg:@"GetAuthFollowingAPI test failed"];
}

- (void)testGetAccountFollowingAPI {
    GetAccountFollowingAPI * api = [[GetAccountFollowingAPI alloc] initWithAccount:self.testAccount AndPage:1];
    [self check:api SuccessCode:200 FailedMsg:@"GetAccountFollowingAPI test failed"];
}

- (void)testGetAccountFollowingAPIWithWrongInfo {
    GetAccountFollowingAPI * api = [[GetAccountFollowingAPI alloc] initWithAccount:self.testWrongInfo AndPage:1];
    [self checkWrongInfo:api FailureCode:404 FailedMsg:@"GetAccountFollowingAPI test failed"];
}

- (void)testSearchUserAPI {
    SearchUserAPI * api = [[SearchUserAPI alloc] initWithSearchStr:self.qstring AndPage:1];
    [self check:api SuccessCode:200 FailedMsg:@"SearchUserAPI test failed"];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
