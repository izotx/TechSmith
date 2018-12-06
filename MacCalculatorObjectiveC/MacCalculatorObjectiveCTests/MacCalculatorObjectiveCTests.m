//
//  MacCalculatorObjectiveCTests.m
//  MacCalculatorObjectiveCTests
//
//  Created by Janusz Chudzynski on 11/29/18.
//  Copyright © 2018 Janusz Chudzynski. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SimpleCalculator.h"
#import "OperationResult.h"


@interface MacCalculatorObjectiveCTests : XCTestCase
    @property SimpleCalculator * calculator;
@end

@implementation MacCalculatorObjectiveCTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _calculator = [SimpleCalculator new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBasicMathOperations {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct     results.
    NSAssert([[_calculator calculate:@"*" first:@"1" andSecond:@"10"]value] == 10, @"It should be 10") ;
    NSAssert([[_calculator calculate:@"-" first:@"10" andSecond:@"5"]value] == 5, @"It should be 5") ;
    NSAssert([[_calculator calculate:@"+" first:@"10" andSecond:@"5"]value] == 15, @"It should be 15") ;
    NSAssert([[_calculator calculate:@"/" first:@"10" andSecond:@"5"]value] == 2, @"It should be 2") ;

}
- (void)testRollingMathOperations {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct     results.
    [_calculator addExpression:@"1"];
    [_calculator addExpression:@"2"];
    float val = [_calculator.currentResult value];
    NSAssert(val == 12,@"Should be 12");
    [_calculator addExpression:@"+"];
    NSAssert([[_calculator lastOperation] isEqualToString:@"+"], @"Last Operation" );
    [_calculator addExpression:@"2"];
    val = [_calculator.currentResult value];
    NSAssert(val == 2,@"Should be 2");
    [_calculator addExpression:@"="];
    val = [_calculator.currentResult value];
    NSString * message = [NSString stringWithFormat:@"Should be 14 %f",val];
    NSAssert(val == 14, message);


    [_calculator addExpression:@"*"];

    val = [_calculator.currentResult value];
    message = [NSString stringWithFormat:@"Should be 14 %f: ",val];
    NSAssert(val == 14, message);

    [_calculator addExpression:@"="];
    val = [_calculator.currentResult value];
    message = [NSString stringWithFormat:@"Should be 28 %f",val];
    NSAssert(val == 28, message);

    [_calculator addExpression:@"+"];
    NSAssert([[_calculator lastOperation] isEqualToString:@"+"], @"Last Operation" );
    [_calculator addExpression:@"2"];
    [_calculator addExpression:@"1"];

    float val6 = [_calculator.currentResult value];
    NSString * message2 = [NSString stringWithFormat:@"Should be 21 And it is: %f",val6];
    NSAssert(val6 == 21, message2);
    
    
    //    NSAssert([[_calculator calculate:@"*" first:@"1" andSecond:@"10"]value] == 10, @"It should be 10") ;
//    NSAssert([[_calculator calculate:@"-" first:@"10" andSecond:@"5"]value] == 5, @"It should be 5") ;
//    NSAssert([[_calculator calculate:@"+" first:@"10" andSecond:@"5"]value] == 15, @"It should be 15") ;
//    NSAssert([[_calculator calculate:@"/" first:@"10" andSecond:@"5"]value] == 2, @"It should be 2") ;
    
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
