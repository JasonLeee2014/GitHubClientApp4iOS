//
//  LoginAPITest.m
//  RequestTests
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginAPI.h"


@interface LoginAPITest : XCTestCase

@end

@implementation LoginAPITest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoginAPIWithCorrectInfo {
    XCTestExpectation* expect = [self expectationWithDescription:@"error"];
    LoginAPI *api = [[LoginAPI alloc] initWithUsername:@"RepoFan" AndPassword:@"COMfan2016"];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        XCTAssertEqual(httpResponse.statusCode,201,@"login api test failed.");
        [expect fulfill];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        XCTFail(@"login api test failed.");
        [expect fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testLoginAPIWithWrongInfo {
    XCTestExpectation* expect = [self expectationWithDescription:@"error"];
    LoginAPI *api = [[LoginAPI alloc] initWithUsername:@"WrongInfo" AndPassword:@"WrongInfo"];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        XCTFail(@"login api test failed.");
        [expect fulfill];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
        XCTAssertEqual(httpResponse.statusCode,401,@"login api test failed.");
        [expect fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
