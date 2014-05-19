//
//  _048Tests.m
//  2048Tests
//
//  Created by mengjq on 5/19/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Calculate.h"
@interface _048Tests : XCTestCase

@end

@implementation _048Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCalculateInit
{
    Calculate *caculate = [Calculate new];
}

@end
