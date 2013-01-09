//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Snake on 12-12-18.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic,strong) CalculatorBrain *caclBrain;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (nonatomic,strong)NSDictionary *testVariableValues;
@property (weak, nonatomic) IBOutlet UILabel *variableValuesList;
@end

@implementation CalculatorViewController
- (CalculatorBrain *)caclBrain{
    if (!_caclBrain) _caclBrain=[[CalculatorBrain alloc] init];
    return _caclBrain;
}
- (IBAction)clearPress {
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.historyLabel.text=@"";
    self.resultLabel.text=@"0";
    self.variableValuesList.text=@"";
    self.testVariableValues = nil;
    [self.caclBrain clearStack];
}

- (IBAction)digiPressed:(UIButton *)sender {
    NSString *digi = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber){
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:digi];
    } else{
        self.resultLabel.text = digi;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPress];
    id result=[self.caclBrain preformOperation:sender.currentTitle];
    self.resultLabel.text=[NSString stringWithFormat:@"%@",result];
    //显示变量和变量的值
    NSSet *variableValuesName;
    self.variableValuesList.text = @"";
    variableValuesName = [CalculatorBrain variablesUsedInProgram:self.caclBrain.program];
    NSNumber *value;
    if (variableValuesName){
        for (NSString *keyname in variableValuesName){
            value = [self.testVariableValues objectForKey:keyname];
            if (!value) value = [NSNumber numberWithDouble:0];
                self.variableValuesList.text =
                [self.variableValuesList.text stringByAppendingString:[NSString stringWithFormat:@"%@ = %@ ",keyname,value]];
        }
    }
    self.historyLabel.text = [CalculatorBrain descriptionOfProgram:self.caclBrain.program];
}
- (IBAction)enterPress {
    [self.caclBrain pushOperand:[self.resultLabel.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.historyLabel.text = [CalculatorBrain descriptionOfProgram:self.caclBrain.program];
}

- (IBAction)pointPress:(UIButton *)sender {
    NSRange pointRange = [self.resultLabel.text rangeOfString:sender.currentTitle];
    if (pointRange.location == NSNotFound){
        if (self.userIsInTheMiddleOfEnteringANumber) {
            self.resultLabel.text = [self.resultLabel.text stringByAppendingString:sender.currentTitle];
        } else {
            self.resultLabel.text = [@"0" stringByAppendingString:sender.currentTitle];
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
    }
}
- (IBAction)signPress {
    if (![self.resultLabel.text isEqualToString:@"0"]){
        if (self.userIsInTheMiddleOfEnteringANumber) {
            self.resultLabel.text = [NSString stringWithFormat:@"%g",0 - [self.resultLabel.text doubleValue]];
        } else{
            id result=[self.caclBrain preformOperation:@"+/-"];
            self.resultLabel.text=[NSString stringWithFormat:@"%@",result];
            self.historyLabel.text = [CalculatorBrain descriptionOfProgram:self.caclBrain.program];
        }
    }

}
- (IBAction)backPress {
    if (self.userIsInTheMiddleOfEnteringANumber){
        if (self.resultLabel.text.length<=1) {
            self.resultLabel.text = @"0";
            self.userIsInTheMiddleOfEnteringANumber = NO;
        } else{
            self.resultLabel.text = [self.resultLabel.text substringToIndex:self.resultLabel.text.length - 1];
        }
    } else{
        [self.caclBrain removeLastObject];
        
    }
}
- (IBAction)variablePress:(UIButton *)sender {
    NSString * variable = sender.currentTitle;
    if (!self.userIsInTheMiddleOfEnteringANumber){
        self.resultLabel.text = variable;
        self.userIsInTheMiddleOfEnteringANumber = NO;
        [self.caclBrain pushVariable:variable];
        self.historyLabel.text = [CalculatorBrain descriptionOfProgram:self.caclBrain.program];
    }
}

- (IBAction)testVariablePress:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"test1"]){
        self.testVariableValues = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:3],@"a",[NSNumber numberWithDouble:4],@"b",nil];
    } else if([sender.currentTitle isEqualToString:@"test2"]){
        self.testVariableValues = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:3],@"a",[NSNumber numberWithDouble:-4],@"x",nil];
    } else if([sender.currentTitle isEqualToString:@"test3"]){
        self.testVariableValues = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:-4],@"x", nil];
    }
    [self.caclBrain pushVariableValues:self.testVariableValues];
}
@end
