//
//  ViewController.m
//  MacCalculatorObjectiveC
//
//  Created by Janusz Chudzynski on 11/29/18.
//  Copyright © 2018 Janusz Chudzynski. All rights reserved.
//

#import "ViewController.h"
#import "OperationResult.h"
#import "SimpleCalculator.h"

@interface ViewController()
    @property SimpleCalculator* calculator;
@end

@implementation ViewController

- (IBAction)buttonAction:(id)sender {
    NSLog(@" %@", [(NSButton *)sender title] );
   [_calculator addExpression:[sender title]];
    OperationResult * result =  _calculator.currentResult;
    NSLog(@" %d", result.value);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _calculator = [SimpleCalculator new];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
