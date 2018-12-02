//
//  SimpleCalculator.m
//  MacCalculatorObjectiveC
//
//  Created by Janusz Chudzynski on 11/29/18.
//  Copyright © 2018 Janusz Chudzynski. All rights reserved.
//

#import "SimpleCalculator.h"
#import "OperationResult.h"

@interface SimpleCalculator()
    @property NSString * lastOperation;
    @property NSMutableString * firstNumber;
    @property NSMutableString * secondNumber;
    @property BOOL firstNumberCompleted;
    @property BOOL secondNumberCompleted;


    @property NSMutableArray * operations;
    @property NSArray * commands;
    @property NSArray * digits;
    @property NSString * displayText;

@end

@implementation SimpleCalculator
- (instancetype)init
{
    self = [super init];
    if (self) {
        _commands = @[@"*",@"/",@"+",@"-",@"=",@"C"];
        NSMutableArray * tempDigits = [NSMutableArray new];
        _secondNumber = [NSMutableString new];
        _firstNumber = [NSMutableString new];
        
        for (int i = 0; i< 10; i++){
            [tempDigits addObject:[NSString stringWithFormat:@"%d",i]];
        }
        _digits = tempDigits;
    }
    return self;
}

    -(void)addExpression:(NSString*)input{
        if([_digits containsObject:input]){
            OperationResult * result = [OperationResult new];
            result.error = NO;
            result.message = @"";
            
            if (!_firstNumberCompleted){
                [_firstNumber  appendString:input];
                result.value = _firstNumber.intValue;
                self.currentResult = result;
            }
            else if(!_secondNumberCompleted){
                [_secondNumber appendString:input];
                result.value = _secondNumber.intValue;
                result.error = NO;
                result.message = @"";
                self.currentResult = result;
            }
            else{//That's a case where both are completed
                //add new digits
                [self clearInput];
                //Recursive call. Not very elegant
                [self addExpression:input];
            }
        }
        else  if([_commands containsObject:input]){
            //evaluate commands
             self.currentResult = [self evaluateCommand:input];
        }
    }




    -(OperationResult*)evaluateCommand:(NSString *)command{
        if([command isEqualToString:@"C"]){
            return [self clearInput];
        }
        else if([command isEqualToString:@"="]){
            //Evaluate expression
            self.secondNumberCompleted = true;
            self.firstNumberCompleted = true;

           return [self calculate:self.lastOperation first:self.firstNumber andSecond:self.secondNumber];
        }
        else{
            _lastOperation = command;
            _firstNumberCompleted = true;
            int val =  _secondNumber.length > 0 ? _secondNumber.intValue : _firstNumber.intValue;
            OperationResult * result = [OperationResult new];
            result.value = val;
            result.error = NO;
            result.message = @"";
            
            return result;
        }
        
    }

#pragma mark TODO REFACTOR THAT. Perhaps in the separate classes conforming to MathCommand Protocol?
-(OperationResult*)calculate:(NSString *)operation first:(NSString*)first andSecond:(NSString*)second{
    int firstNumber = (first != nil)? first.intValue : 0;
    int secondNumber = (second != nil)? second.intValue : 0;
    
    if ([operation isEqualToString:@"+"]){
        return [self addFirst:firstNumber secondNumber:secondNumber];
    }
    else if ([operation isEqualToString:@"-"]){
        return [self substractFirst:firstNumber secondNumber:secondNumber];
    }
    else if ([operation isEqualToString:@"*"]){
        return [self multiplyFirst:firstNumber secondNumber:secondNumber];
    }
    else if ([operation isEqualToString:@"/"]){
        return [self divideFirst:firstNumber secondNumber:secondNumber];
    }
    else{
        OperationResult * result = [OperationResult new];
        result.value = -1;
        result.error = YES;
        result.message = @"Unknown Operation";

        return result;
    }
}

-(OperationResult *)addFirst:(int) first secondNumber:(int)second{
    OperationResult * result = [OperationResult new];
    result.value = first + second;
    result.error = NO;
    result.message = nil;
    
    return  result;
}

-(OperationResult *)substractFirst:(int) first secondNumber:(int)second{
    OperationResult * result = [OperationResult new];
    result.value = first - second;
    result.error = NO;
    result.message = nil;
    
    return  result;
}

-(OperationResult *)multiplyFirst:(int) first secondNumber:(int)second{
    OperationResult * result = [OperationResult new];
    result.value = first * second;
    result.error = NO;
    result.message = nil;
    
    return  result;
}

-(OperationResult *)divideFirst:(int) first secondNumber:(int)second{
    OperationResult * result = [OperationResult new];
    if( second == 0)
    {
        result.value = -1;
        result.error = YES;
        result.message = @"Can't divide by 0!";
        
        return  result;
    }
    else{
        result.value = first * 1.0/ second * 1.0;
        result.error = NO;
        result.message = @"";
        
        return  result;
    }
}

-(OperationResult *)clearInput{
    _secondNumber = [NSMutableString new];
    _firstNumber = [NSMutableString new];
    _firstNumberCompleted = false;
    _secondNumberCompleted = false;
    _lastOperation = nil;
    
    OperationResult * result = [OperationResult new];
    result.value = 0;
    result.error = NO;
    result.message = @"";
    
    return  result;
}

@end
