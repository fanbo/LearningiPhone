//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Snake on 12-12-18.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic,strong)NSMutableArray *operationStack;
@end

@implementation CalculatorBrain

- (NSMutableArray *)operationStack{
    if (!_operationStack) _operationStack=[[NSMutableArray alloc] init];
    return _operationStack;
}
- (void)pushOperand:(double)operand{
    [self.operationStack addObject:[NSNumber numberWithDouble:operand]];
}
- (double)popOperand{
    NSNumber *operandObject=[self.operationStack lastObject];
    if (operandObject)[self.operationStack removeLastObject];
    return [operandObject doubleValue];
}
- (double)preformOperation:(NSString *)operation{
    double result = 0;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"-"]){
        double tempNumber = [self popOperand];
        result = [self popOperand] - tempNumber;
    } else if ([operation isEqualToString:@"*"]){
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"/"]){
        double tempNumber = [self popOperand];
        if (tempNumber) result = [self popOperand] / tempNumber;
    } else if ([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"log"]){
        result = log([self popOperand]);
    }else if ([operation isEqualToString:@"pai"]){
        result = M_PI;
    } else if ([operation isEqualToString:@"+/-"]){
        result = 0 - [self popOperand];
    }
    [self pushOperand:result];
    return result;
}
- (NSString *)description{
    return [NSString stringWithFormat:@"stack = %@",self.operationStack];
}
- (void)clearStack{
    if (self.operationStack) [self.operationStack removeAllObjects];
}
@end
