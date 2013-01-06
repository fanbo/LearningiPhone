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
@end

@implementation CalculatorBrain

- (NSMutableArray *)programStack{
    if (!_programStack) _programStack=[[NSMutableArray alloc] init];
    return _programStack;
}
- (void)pushOperand:(double)operand{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}
- (void)pushVirable:(NSString *)variable{
    [self.programStack addObject:variable];
}
- (void)preformOperation:(NSString *)operation{
    [self.programStack addObject:operation];
}
- (id)program{
    return [self.programStack copy];
}
+ (NSString *)descriptionOfProgram:(id)program{
    return @"Implement this in Assigment 2";
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
+ (double)runProgram:(id)program{
    return [self popOperandOffStack:program];
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues{
    NSMutableArray *stack;
    id value;
    if ([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    for (NSUInteger keyIndex=0; keyIndex<stack.count; keyIndex++) {
        if ([[stack objectAtIndex:keyIndex] isKindOfClass:[NSString class]]){
            value = [variableValues valueForKey:[stack objectAtIndex:keyIndex]];
            if (value) {
                [stack replaceObjectAtIndex:keyIndex withObject:value];
            }
        }
    }
    return [self runProgram:stack];
}

+ (NSSet *)variablesUsedInProgram:(id)program{
    NSArray *variables;
    NSMutableSet *variableSet = [[NSMutableSet alloc] init];
    if ([program isKindOfClass:[NSArray class]]){
        variables=[program copy];
    }
    for (id object in variables){
        if ([object isKindOfClass:[NSString class]]){
            if (![object isEqualToString:@"+"]&&![object isEqualToString:@"-"]&&![object isEqualToString:@"*"]&&
                ![object isEqualToString:@"/"]&&![object isEqualToString:@"sin"]&&![object isEqualToString:@"cos"]&&
                ![object isEqualToString:@"sqrt"]&&![object isEqualToString:@"log"]&&![object isEqualToString:@"pai"]&&
                ![object isEqualToString:@"+/-"]){
                [variableSet addObject:(NSString *)object];
            }
        }
    }
    return [variableSet copy];
}
- (void)clearStack{
    if (self.programStack) [self.programStack removeAllObjects];
}
@end
