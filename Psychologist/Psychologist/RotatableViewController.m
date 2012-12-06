//
//  RotatableViewController.m
//  Psychologist
//
//  Created by Snake on 12-12-4.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import "RotatableViewController.h"

@interface RotatableViewController ()

@end

@implementation RotatableViewController
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.splitViewController.delegate=self;
}

-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}

@end
