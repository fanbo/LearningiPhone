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
- (id)preformOperation:(NSString *)operation{
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
+ (id)popOperandOffStack:(NSMutableArray *)stack{
    double result = 0;
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    if ([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]){
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [[self popOperandOffStack:stack]doubleValue] + [[self popOperandOffStack:stack] doubleValue];
        } else if ([operation isEqualToString:@"-"]){
            double tempNumber = [[self popOperandOffStack:stack] doubleValue];
            result = [[self popOperandOffStack:stack] doubleValue] - tempNumber;
        } else if ([operation isEqualToString:@"*"]){
            result = [[self popOperandOffStack:stack] doubleValue]* [[self popOperandOffStack:stack] doubleValue];
        } else if ([operation isEqualToString:@"/"]){
            double tempNumber = [[self popOperandOffStack:stack] doubleValue];
            if (tempNumber == 0) return @"err: dividend is Zero";
            result = [[self popOperandOffStack:stack] doubleValue] / tempNumber;
        } else if ([operation isEqualToString:@"sin"]){
            result = sin([[self popOperandOffStack:stack] doubleValue]);
        } else if ([operation isEqualToString:@"cos"]){
            result = cos([[self popOperandOffStack:stack] doubleValue]);
        } else if ([operation isEqualToString:@"sqrt"]){
            double sqrtNumber = [[self popOperandOffStack:stack] doubleValue];
            if (sqrtNumber < 0) return @"err:not a valid number";
            result = sqrt(sqrtNumber);
        } else if ([operation isEqualToString:@"log"]){
            result = log([[self popOperandOffStack:stack] doubleValue]);
        }else if ([operation isEqualToString:@"pai"]){
            result = M_PI;
        } else if ([operation isEqualToString:@"+/-"]){
            result = 0 - [[self popOperandOffStack:stack]doubleValue];
        }else{
            return @"err:unknow operation";
        }
    }
    return [NSNumber numberWithDouble:result];
}
- (void)removeLastObject{
    if ([self.programStack lastObject]) {
        [self.programStack removeLastObject];
    }
}
+ (BOOL)isVarialbeValue:(NSString *)testStr{
    if ([testStr isEqualToString:@"a"]||[testStr isEqualToString:@"b"]||[testStr isEqualToString:@"x"]){
        return YES;
    }else {
        return NO;
    }
}
+ (BOOL)isTwoOperandOperation:(NSString *)tesStr{
    if ([tesStr isEqualToString:@"+"]||[tesStr isEqualToString:@"-"]||[tesStr isEqualToString:@"*"]||[tesStr isEqualToString:@"/"]){
        return YES;
    }else{
        return NO;
    }
}
+ (BOOL)isOneOperandOperation:(NSString *)testStr{
    if ([testStr isEqualToString:@"sin"]||[testStr isEqualToString:@"cos"]||[testStr isEqualToString:@"sqrt"]||[testStr isEqualToString:@"log"]||[testStr isEqualToString:@"+/-"]){
        return YES;
    }else{
        return NO;
    }
}
+ (NSString *)descriptionOfStack:(NSMutableArray *)stack{
    NSString *result = @"";
    id objectOfStack = [stack lastObject];
    if (objectOfStack) [stack removeLastObject];
    if ([objectOfStack isKindOfClass:[NSNumber class]]){
        result = [objectOfStack stringValue];
    } else if ([self isVarialbeValue:objectOfStack]){
        result = objectOfStack;
    } else if ([self isTwoOperandOperation:objectOfStack]){
        NSString *secondOperand = [self descriptionOfStack:stack];
        NSString *firstOperand = [self descriptionOfStack:stack];
        if ([objectOfStack isEqualToString:@"*"]||[objectOfStack isEqualToString:@"/"]) {
            result = [NSString stringWithFormat:@"%@ %@ %@",firstOperand,objectOfStack,secondOperand];
        } else {
            result = [NSString stringWithFormat:@"(%@ %@ %@)",firstOperand,objectOfStack,secondOperand];
        }
    } else if ([self isOneOperandOperation:objectOfStack]){
        NSString *Operand = [self descriptionOfStack:stack];
        if ([Operand hasPrefix:@"("]){
            result = [objectOfStack stringByAppendingString:[NSString stringWithFormat:@"%@",Operand]];
        } else {
            result = [objectOfStack stringByAppendingString:[NSString stringWithFormat:@"(%@)",Operand]];
        }
        
    } else {
        result = objectOfStack;
    }
    return result;
}
//显示友好的计算状态
+ (NSString *)descriptionOfProgram:(id)program{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    NSString *result=@"";
    NSString *tempStr=@"";
    do {
        tempStr = [self descriptionOfStack:stack];
        if ([tempStr hasPrefix:@"("]&&[tempStr hasSuffix:@")"]){
            tempStr = [tempStr substringWithRange:NSMakeRange(1, tempStr.length - 2)];
        }if ([result isEqualToString:@""]){
            result = [NSString stringWithFormat:@"%@",tempStr];
        } else{
            result = [NSString stringWithFormat:@"%@ , %@",result,tempStr];
        }
    } while (stack.count != 0);
    if ([result hasSuffix:@","]) [result substringWithRange:NSMakeRange(0, result.length - 2)];
    return result;
}
+ (id)runProgram:(id)program{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}
//支持变量的计算器，将变量明替换成数值
+ (id)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues{
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
    }
    if ([stack containsObject:@"b"]){
        [variable addObject:@"b"];
    }
    if ([stack containsObject:@"x"]){
        [variable addObject:@"x"];
    }
    if (variable.count == 0){
        return nil;
    }
    return [variable copy];
}
- (void)clearStack{
    if (self.programStack) [self.programStack removeAllObjects];
    if (self.variableValues) self.variableValues = nil;
}
@end
