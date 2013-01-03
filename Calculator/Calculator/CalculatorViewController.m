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
    [self.caclBrain clearStack];
}

- (IBAction)digiPressed:(UIButton *)sender {
    NSString *digi = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber){
        self.resultLabel.text=[self.resultLabel.text stringByAppendingString:digi];
    } else{
        self.resultLabel.text = digi;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPress];
    double result=[self.caclBrain preformOperation:sender.currentTitle];
    self.resultLabel.text=[NSString stringWithFormat:@"%g",result];
    [self addHistoryLabel:sender.currentTitle isOperationPress:YES];
}
- (IBAction)enterPress {
    [self.caclBrain pushOperand:[self.resultLabel.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self addHistoryLabel:self.resultLabel.text isOperationPress:NO];
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
- (void)addHistoryLabel:(NSString *)histroy isOperationPress:(BOOL)isOperationPress{
    self.historyLabel.text=[self.historyLabel.text stringByAppendingString:[histroy stringByAppendingString:@"  "]];
    NSRange range =[self.historyLabel.text rangeOfString:@"="];
    if (range.location == NSNotFound){
        if (isOperationPress) self.historyLabel.text=[self.historyLabel.text stringByAppendingString:@"="];
    } else{
        if (!isOperationPress){
            self.historyLabel.text=[self.historyLabel.text stringByReplacingCharactersInRange:range withString:@""];
        }else{
            self.historyLabel.text=[[self.historyLabel.text stringByReplacingCharactersInRange:range withString:@""] stringByAppendingString:@"="];
        }
    }
}
- (IBAction)signPress {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.resultLabel.text = [NSString stringWithFormat:@"%g",0 - [self.resultLabel.text doubleValue]];
    } else{
        double result=[self.caclBrain preformOperation:@"+/-"];
        self.resultLabel.text=[NSString stringWithFormat:@"%g",result];
        [self addHistoryLabel:@"+/-" isOperationPress:YES];
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
    }
}
@end
