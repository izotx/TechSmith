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

@interface ViewController() <NSTextFieldDelegate,NSControlTextEditingDelegate>
@property (weak) IBOutlet NSTextField *labelField;
@property (weak) IBOutlet NSTextField *displayField;
@property SimpleCalculator* calculator;
@end

@implementation ViewController

- (IBAction)buttonAction:(id)sender {
    [self addExpression:[sender title]];
    [self refreshScreen];
}


-(void)addExpression:(NSString*)expression{
   [_calculator addExpression:expression];
}

-(void)refreshScreen{
    OperationResult * result =  _calculator.currentResult;
    [_displayField setStringValue:[NSString stringWithFormat:@"%d",result.value]];
    [_labelField setStringValue:[NSString stringWithFormat:@"%@",result.message]];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    _calculator = [SimpleCalculator new];
    _displayField.delegate = self;
    _labelField.editable = NO;
    //Add Observer
    [_calculator addObserver:self forKeyPath:@"currentResult" options:NSKeyValueObservingOptionNew context:nil];
    
    
    // Do any additional setup after loading the view.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"Observe Value: %@ %@",keyPath,[change objectForKey:@"new"]);
    [self refreshScreen];
    
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor{
    
    NSLog(@"SHould End Editing %@",fieldEditor);
    return true;
}

-(void)controlTextDidChange:(NSNotification *)notification{
    NSString * val = [(NSTextField*) notification.object stringValue];
    NSString*  last = [val substringWithRange:NSMakeRange(val.length -1, 1)];
    NSLog(@"Did Change %@",[(NSTextField*) notification.object stringValue] );
    NSLog(@"Last Change %@", last );
    
    [self addExpression:last];
    [self refreshScreen];
    
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector{
    
    NSLog(@"Command Selector %@ ",  NSStringFromSelector(commandSelector));
    
    return true;
}

//Detecting Key Down
- (void)keyDown:(NSEvent *)event{
    NSLog(@"Key Down %@",event);
}


@end
