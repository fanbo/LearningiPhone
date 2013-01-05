//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Snake on 12-12-18.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void)pushOperand:(double)operand;
- (void)pushVirable:(NSString *)variable;
- (void)preformOperation:(NSString *)operation;
- (void)clearStack;
@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
+ (NSString *)descriptionOfProgram:(id)program;
+ (NSSet *)variablesUsedInProgram:(id)program;
@end
