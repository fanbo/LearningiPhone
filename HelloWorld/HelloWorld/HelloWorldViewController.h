//
//  HelloWorldViewController.h
//  HelloWorld
//
//  Created by Snake on 12-12-6.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloWorldViewController : UIViewController<UITextFieldDelegate>
@property (copy,nonatomic) NSString *userName;
@end
