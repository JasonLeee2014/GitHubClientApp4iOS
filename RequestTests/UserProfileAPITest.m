//
//  UserProfileAPITest.m
//  RequestTests
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RequestBaseTest.h"
#import "GetAuthUserAPI.h"
#import "GetAccountUserAPI.h"

@interface UserProfileAPITest : RequestBaseTest

@end

@implementation UserProfileAPITest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetAuthUserAPI {
    GetAuthUserAPI *api = [[GetAuthUserAPI alloc] init];
    [self check:api SuccessCode:200 FailedMsg:@"GetAuthUserAPI test failed"];
}

- (void)testGetAccountUserProfileAPI {
    GetAccountUserAPI *api = [[GetAccountUserAPI alloc] initWithAccountName:self.testAccount];
    [self check:api SuccessCode:200 FailedMsg:@"GetAuthUserAPI test failed"];
}

- (void)testGetAccountUserProfileAPIWithWrongInfo {
    GetAccountUserAPI *api = [[GetAccountUserAPI alloc] initWithAccountName:self.testWrongInfo];
    [self checkWrongInfo:api FailureCode:404 FailedMsg:@"GetAccountUserProfileAPI test failed"];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
