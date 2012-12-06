//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Snake on 12-9-23.
//  Copyright (c) 2012年 snake well. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
-(void)clearOperation;

@property (readonly) id program;
+(double)runProgram:(id)program;
+(double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
+(NSSet *)variablesUsedInProgram:(id)program;
+(NSString *)descriptionOfProgram:(id)program;
@end
