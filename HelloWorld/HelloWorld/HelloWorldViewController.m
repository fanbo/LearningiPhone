//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by Snake on 12-12-6.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()
- (IBAction)changeGreeting:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *TestField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation HelloWorldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeGreeting:(id)sender {
    self.userName=self.TestField.text;
    NSString *nameString=self.userName;
    if ([nameString length]==0){
        nameString=@"World";
    }
    NSString *greeting =[[NSString alloc] initWithFormat:@"Hello,%@!",nameString];
    self.label.text=greeting;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.TestField){
        [textField resignFirstResponder];
        self.label.text=@"DONE";
    }
    return NO;//对于返回值YES或者NO反应都一样，但是文档内说是YES用于处理文本框自定义行为，NO是不执行
}
@end
