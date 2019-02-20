//
//  RequestBaseTest.m
//  RequestTests
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "RequestBaseTest.h"
#import <OCMock.h>

@implementation RequestBaseTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    id userDefaultsMock = OCMClassMock([NSUserDefaults class]);
    OCMStub([userDefaultsMock valueForKey:@"token"]).andReturn(@"6c8c4191bac3eb4a43d9ecef6efc8c6ecbd1f7e4");
    OCMStub([userDefaultsMock standardUserDefaults]).andReturn(userDefaultsMock);
    
    self.testAccount = @"yyx990803";
    self.testWrongInfo = @"wronginfo";
    self.qstring = @"github";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)check:(id)api SuccessCode:(NSInteger)successCode FailedMsg:(NSString*)msg{
    XCTestExpectation* expect = [self expectationWithDescription:@"error"];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        XCTAssertEqual(httpResponse.statusCode,successCode,@"%@",msg);
        [expect fulfill];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        XCTFail(@"%@",msg);
        [expect fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)checkWrongInfo:(id)api FailureCode:(NSInteger)failureCode FailedMsg:(NSString*)msg{
    XCTestExpectation* expect = [self expectationWithDescription:@"error"];
    [api startRequestWithSuccess:^(NSURLSessionTask *task, id responseObject) {
        XCTFail(@"%@",msg);
        [expect fulfill];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
        XCTAssertEqual(httpResponse.statusCode,failureCode,@"%@",msg);
        [expect fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
