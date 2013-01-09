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
- (id)preformOperation:(NSString *)operation;
- (void)removeLastObject;
- (void)pushVariable:(NSString *)variableName;
- (void)pushVariableValues:(NSDictionary *)variableValues;
- (void)clearStack;

@property (readonly) id program;

+ (id)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;
+ (id)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
+ (NSSet *)variablesUsedInProgram:(id)program;
@end
