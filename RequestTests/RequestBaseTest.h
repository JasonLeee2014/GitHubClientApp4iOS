//
//  RequestBaseTest.h
//  RequestTests
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIRequester.h"

@interface RequestBaseTest : XCTestCase

@property NSString* testAccount;
@property NSString* testWrongInfo;
@property NSString* qstring;

- (void)check:(id)api SuccessCode:(NSInteger)successCode FailedMsg:(NSString*)msg;

- (void)checkWrongInfo:(id)api FailureCode:(NSInteger)failureCode FailedMsg:(NSString*)msg;

@end
