//
//  ProfileViewControllerUnitTest.m
//  AS3Tests
//
//  Created by zaka on 15/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProfileViewController.h"

@interface ProfileViewController (UnitTest)
- (NSMutableArray*)slice:(NSString*)string;
-(void)checkStatus;
@end

@interface ProfileViewControllerUnitTest : XCTestCase

@end

@implementation ProfileViewControllerUnitTest{
    ProfileViewController* vc;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    vc = [ProfileViewController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    XCTAssertNotNil(vc, @"ProfileViewController init failed.");
}

- (void)testSlice {
    NSMutableArray* slicedArray = [vc slice:@"testing slice fuction."];
    NSMutableArray* expectResult = [[NSMutableArray alloc] initWithArray:@[@"testing",@" ",@"slice",@" ",@"fuction",@"."]];
    XCTAssertTrue([slicedArray isEqualToArray:expectResult],@"slice function have error");
}

- (void)testCheckStatus{
    [vc checkStatus];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
