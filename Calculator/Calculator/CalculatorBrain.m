//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Snake on 12-9-23.
//  Copyright (c) 2012年 snake well. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain
@synthesize programStack=_programStack;
-(NSMutableArray *)programStack{
    if(!_programStack){
        _programStack=[[NSMutableArray alloc] init];
    }
    return _programStack;
}
-(id)program{
    return [self.programStack copy];
}

-(void)pushOperand:(double)operand{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
    
}
-(void)clearOperation{
    [self.programStack removeAllObjects];
}


-(double)performOperation:(NSString *)operation{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.programStack];
}

+(double)popOperandOffStack:(NSMutableArray *) stack{
    double result=0;
    id topOfStack=[stack lastObject];
    if (topOfStack) [stack removeLastObject];
    if ([topOfStack isKindOfClass:[NSNumber class]]){
        result=[topOfStack doubleValue];
    }else if ([topOfStack isKindOfClass:[NSString class]]){
        NSString *operation=topOfStack;
        if([operation isEqualToString:@"+"]){
            result=[self popOperandOffStack:stack]+[self popOperandOffStack:stack];
        }else if ([operation isEqualToString:@"*"]){
            result=[self popOperandOffStack:stack]*[self popOperandOffStack:stack];
        }else if ([operation isEqualToString:@"-"]){
            result=-([self popOperandOffStack:stack]-[self popOperandOffStack:stack]);
        }else if([operation isEqualToString:@"/"]){
            double divisor=[self popOperandOffStack:stack];
            if (divisor) result=[self popOperandOffStack:stack]/divisor;
        }else if([operation isEqualToString:@"sin"]){
            result=sin([self popOperandOffStack:stack]);
        }else if([operation isEqualToString:@"cos"]){
            result=cos([self popOperandOffStack:stack]);
        }else if([operation isEqualToString:@"sqrt"]){
            result=sqrt([self popOperandOffStack:stack]);
        }else if([operation isEqualToString:@"pai"]){
            result=M_PI;
        }

    }
    
    return result;
}

+(NSString *)descriptionOfProgram:(id)program{
    return @"Implement this in Assignment 2";
}

+(double)runProgram:(id)program{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]){
        stack=[program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

@end
