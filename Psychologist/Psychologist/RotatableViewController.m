//
//  RotatableViewController.m
//  Psychologist
//
//  Created by Snake on 12-12-4.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import "RotatableViewController.h"
#import "splitViewbarButtonItemPresenter.h"
@interface RotatableViewController ()

@end

@implementation RotatableViewController
//-(void)awakeFromNib
//{
//    [super awakeFromNib];
//    self.splitViewController.delegate=self;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.splitViewController.delegate=self;
}

- (id <splitViewbarButtonItemPresenter>)splitViewBarButtonItemPresenter{
    id detailVC = [self.splitViewController.viewControllers lastObject];
    if (![detailVC conformsToProtocol:@protocol(splitViewbarButtonItemPresenter) ]){//如果当前的的viewController不能响应该协议
        detailVC=nil;
    }
    return detailVC;
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation{
    //return [self splitViewBarButtonItemPresenter] ? YES:NO; //如果响应协议那么就隐藏边列如果不能响应那么就不隐藏了，但是不能一直显示presenter
    return [self splitViewBarButtonItemPresenter] ? UIInterfaceOrientationIsPortrait(orientation) : NO;
}
- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    barButtonItem.title=self.title;
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = barButtonItem;
}
- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = nil;
}
@end
