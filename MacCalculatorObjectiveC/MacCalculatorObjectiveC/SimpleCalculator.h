//
//  SimpleCalculator.h
//  MacCalculatorObjectiveC
//
//  Created by Janusz Chudzynski on 11/29/18.
//  Copyright © 2018 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OperationResult;

@interface SimpleCalculator : NSObject
    -(void)addExpression:(NSString*)input;
    -(OperationResult*)evaluateCommand:(NSString *)command;
-(OperationResult*)calculate:(NSString *)operation first:(NSString*)first andSecond:(NSString*)second;

    @property OperationResult * currentResult;
@end
