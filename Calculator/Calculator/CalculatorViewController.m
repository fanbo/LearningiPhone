//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Snake on 12-9-23.
//  Copyright (c) 2012年 snake well. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL dotIsEnter;
@property (nonatomic,strong)CalculatorBrain *brain;
@end
@implementation CalculatorViewController

@synthesize display=_display;
@synthesize brain=_brain;
@synthesize userIsTheMiddleOfEnteringANumber=_userIsTheMiddleOfEnteringANumber;
@synthesize dotIsEnter=_dotIsEnter;
@synthesize historyDisplay=_historyDisplay;


-(CalculatorBrain *)brain{
    if (!_brain) {
        _brain=[[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digiPressed:(UIButton *)sender {
    NSString *digi=sender.currentTitle;
    if (self.userIsTheMiddleOfEnteringANumber) {
        self.display.text=[self.display.text stringByAppendingString:digi];
    }else{
        self.display.text=digi;
        self.userIsTheMiddleOfEnteringANumber=YES;
    }
}

- (IBAction)dotPressed:(UIButton *)sender {
    if(!self.dotIsEnter){
        if (self.userIsTheMiddleOfEnteringANumber){
            self.display.text=[self.display.text stringByAppendingString:sender.currentTitle];
        }else{
            self.display.text=[@"0" stringByAppendingString:sender.currentTitle];
            self.userIsTheMiddleOfEnteringANumber=YES;
        }
        self.dotIsEnter=YES;
    }
}

- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsTheMiddleOfEnteringANumber){
        [self enterPressed];
    }
    NSString *operation=sender.currentTitle;
    double result=[self.brain performOperation:operation];
    self.display.text=[NSString stringWithFormat:@"%g",result];
    self.historyDisplay.text=[self.historyDisplay.text stringByAppendingString:@" "];
    self.historyDisplay.text=[self.historyDisplay.text stringByAppendingString:operation];
    self.historyDisplay.text=[self.historyDisplay.text stringByAppendingString:@" ="];
}

- (IBAction)backspacePressed:(id)sender {
    if(self.userIsTheMiddleOfEnteringANumber){
        if([self.display.text length]<=1){
            self.display.text=@"0";
            self.userIsTheMiddleOfEnteringANumber=NO;
        }else{
            self.display.text=[self.display.text substringToIndex:[self.display.text length] - 1];
        }
    }
}
- (IBAction)plusminusPressed:(id)sender {
    if(self.userIsTheMiddleOfEnteringANumber){
        double number;
        number= - [self.display.text doubleValue];
        self.display.text=[NSString stringWithFormat:@"%g",number];
    }
}
- (IBAction)setTestValue:(UIButton *)sender {
    NSDictionary *valueDictionary=[[NSDictionary alloc] init];
    if ([sender.currentTitle isEqualToString:@"test1"]){
        [valueDictionary setValue:[NSNumber numberWithDouble:3] forKey:@"x"];
        [valueDictionary setValue:[NSNumber numberWithDouble:4] forKey:@"a"];
        [valueDictionary setValue:[NSNumber numberWithDouble:5] forKey:@"b"];
        
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsTheMiddleOfEnteringANumber=NO;
    self.dotIsEnter=NO;
    self.historyDisplay.text=[self.historyDisplay.text stringByAppendingString:@" "];
    self.historyDisplay.text=[self.historyDisplay.text stringByAppendingString:self.display.text];
}
- (IBAction)clearPressed:(UIButton *)sender {
    self.historyDisplay.text=@"";
    self.display.text=@"0";
    [self.brain clearOperation];
}
@end
