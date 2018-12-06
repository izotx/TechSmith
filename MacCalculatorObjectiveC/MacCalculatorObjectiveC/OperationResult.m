//
//  OperationResult.m
//  MacCalculatorObjectiveC
//
//  Created by Janusz Chudzynski on 11/29/18.
//  Copyright © 2018 Janusz Chudzynski. All rights reserved.
//

#import "OperationResult.h"

@implementation OperationResult


-(NSString*) textValue{
   
    return [NSString stringWithFormat:@"%f",self.value];
}

@end
