//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Snake on 12-12-18.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic,strong)NSMutableArray *programStack;
@property (nonatomic,strong)NSDictionary *variableValues;
@end

@implementation CalculatorBrain

- (NSMutableArray *)programStack{
    if (!_programStack) _programStack=[[NSMutableArray alloc] init];
    return _programStack;
}
- (NSDictionary *)variableValues{
    if (!_variableValues) _variableValues = [[NSDictionary alloc] init];
    return _variableValues;
}
- (void)pushOperand:(double)operand{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}
- (void)pushVariableValues:(NSDictionary *)variableValues{
    self.variableValues = variableValues;
}
- (double)preformOperation:(NSString *)operation{
    [self.programStack addObject:operation];
    if ([CalculatorBrain variablesUsedInProgram:self.program]){
        return [CalculatorBrain runProgram:self.program usingVariableValues:self.variableValues];
    }
    return [CalculatorBrain runProgram:self.program];
}
- (void)pushVariable:(NSString *)variableName{
    [self.programStack addObject:variableName];
}

- (id)program{
    return [self.programStack copy];
}
+ (double)popOperandOffStack:(NSMutableArray *)stack{
    double result = 0;
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    if ([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]){
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"-"]){
            double tempNumber = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - tempNumber;
        } else if ([operation isEqualToString:@"*"]){
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"/"]){
            double tempNumber = [self popOperandOffStack:stack];
            if (tempNumber) result = [self popOperandOffStack:stack] / tempNumber;
        } else if ([operation isEqualToString:@"sin"]){
            result = sin([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"cos"]){
            result = cos([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"sqrt"]){
            result = sqrt([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"log"]){
            result = log([self popOperandOffStack:stack]);
        }else if ([operation isEqualToString:@"pai"]){
            result = M_PI;
        } else if ([operation isEqualToString:@"+/-"]){
            result = 0 - [self popOperandOffStack:stack];
        }
    }
    return result;
}
+ (NSString *)descriptionOfProgram:(id)program{
    return @"";
}
+ (double)runProgram:(id)program{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}
//支持变量的计算器，将变量明替换成数值
+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    for (int index = 0; index < stack.count; index++) {
        id variableName = [stack objectAtIndex:index];
        if ([variableName isKindOfClass:[NSString class]]&&
            ([variableName isEqualToString:@"a"]||
             [variableName isEqualToString:@"b"]||
             [variableName isEqualToString:@"x"])){
                if ([variableValues objectForKey:variableName]){
                    [stack replaceObjectAtIndex:index withObject:[variableValues objectForKey:variableName]];
                } else{
                    [stack replaceObjectAtIndex:index withObject:[NSNumber numberWithDouble:0]];
                }
            }
    }
    return [self popOperandOffStack:stack];
}
//返回当前计算器所使用的变量名称
+ (NSSet *)variablesUsedInProgram:(id)program{
    NSMutableSet *variable = [[NSMutableSet alloc] initWithCapacity:3];
    NSArray *stack;
    if ([program isKindOfClass:[NSArray class]]){
        stack = [program copy];
    }
    if ([stack containsObject:@"a"]){
        [variable addObject:@"a"];
    } else if ([stack containsObject:@"b"]){
        [variable addObject:@"b"];
    }else if ([stack containsObject:@"x"]){
        [variable addObject:@"x"];
    }
    if (variable.count == 0){
        return nil;
    }
    return [variable copy];
}
- (void)clearStack{
    if (self.programStack) [self.programStack removeAllObjects];
}
@end
