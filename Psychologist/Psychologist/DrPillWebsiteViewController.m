//
//  DrPillWebsiteViewController.m
//  Psychologist
//
//  Created by Snake on 12-12-14.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import "DrPillWebsiteViewController.h"

@interface DrPillWebsiteViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation DrPillWebsiteViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.webView.scalesPageToFit=YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
}

@end
