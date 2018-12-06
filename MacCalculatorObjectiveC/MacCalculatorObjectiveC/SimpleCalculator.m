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

    @property NSMutableString * firstNumber;
    @property NSMutableString * secondNumber;
    @property NSMutableString * lastSecondNumber;
    @property BOOL firstNumberCompleted;
    //@property BOOL secondNumberCompleted;


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
                result.value = _firstNumber.floatValue;
                self.currentResult = result;
            }
            else{
                [_secondNumber appendString:input];
                result.value = _secondNumber.floatValue;
                result.error = NO;
                result.message = @"";
                self.currentResult = result;
            }
        }
        else  if([_commands containsObject:input]){
            //evaluate commands
             self.currentResult = [self evaluateCommand:input];
        }
    }
//2 questions
// what happens when user enter enter twice
// keep repeating the same operation
// what happens when user enters digits after enter
// first number becomes result, so
// if equal repeat previous operation
// if any other sign
// remember the sign
// start typing another operation (resets the second number)
//
   -(OperationResult*)evaluateCommand:(NSString *)command{
        if([command isEqualToString:@"C"]){
            return [self clearInput];
        }
        else if([command isEqualToString:@"="]){
            
            if(self.lastOperation){
                
                if(self.secondNumber.length > 0){
                    self.currentResult  = [self calculate:self.lastOperation first:self.firstNumber andSecond:self.secondNumber];
                }
                else{
                    self.currentResult  = [self calculate:self.lastOperation first:self.firstNumber andSecond:self.lastSecondNumber];
                }
               
                if (self.secondNumber.length >0){
                    self.lastSecondNumber = self.secondNumber;
                    self.secondNumber = [NSMutableString new];
                }
                self.firstNumberCompleted = true;
                self.firstNumber = [NSMutableString stringWithFormat:@"%f",self.currentResult.value];

                return self.currentResult;
            }
            else{
                return self.currentResult;
            }
        }
        else{
            _lastOperation = command;
            _firstNumberCompleted = true;
            self.firstNumber = [NSMutableString stringWithFormat:@"%f",self.currentResult.value];
            
            return self.currentResult;
        }
        
    }

#pragma mark TODO REFACTOR THAT. Perhaps in the separate classes conforming to MathCommand Protocol?
-(OperationResult*)calculate:(NSString *)operation first:(NSString*)first andSecond:(NSString*)second{
    float firstNumber = (first != nil)? first.floatValue : 0;
    float secondNumber = (second != nil)? second.floatValue : 0;
    
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

-(OperationResult *)addFirst:(float) first secondNumber:(float)second{
    OperationResult * result = [OperationResult new];
    result.value = first + second;
    result.error = NO;
    result.message = nil;
    
    return  result;
}

-(OperationResult *)substractFirst:(float) first secondNumber:(float)second{
    OperationResult * result = [OperationResult new];
    result.value = first - second;
    result.error = NO;
    result.message = nil;
    
    return  result;
}

-(OperationResult *)multiplyFirst:(float) first secondNumber:(float)second{
    OperationResult * result = [OperationResult new];
    result.value = first * second;
    result.error = NO;
    result.message = nil;
    
    return  result;
}

-(OperationResult *)divideFirst:(float) first secondNumber:(float)second{
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
    _lastOperation = nil;
    
    OperationResult * result = [OperationResult new];
    result.value = 0;
    result.error = NO;
    result.message = @"";
    
    return  result;
}

@end
