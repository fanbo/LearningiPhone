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
    }
    return NO;//对于返回值YES或者NO反应都一样，但是文档内说是YES用于处理文本框自定义行为，NO是不执行
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //当在文本框内编辑时，标签栏同时显示输入的内容
    if (textField==self.TestField){
        self.label.text=[self.label.text stringByAppendingString:string];
    }
return YES;//返回YES表示正常的输入状态，返回NO文本框不会显示输入的文字
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    //当开始编辑文本框时，清空文本框和标签栏的原始信息
//    if(textField==self.TestField){
//        textField.text=@"";
//        self.label.text=@"";
//    }
//}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //当开始编辑文本框时，清空文本框和标签栏的原始信息
    if(textField==self.TestField){
        textField.text=@"";
        self.label.text=@"";
    }
    return YES;//返回YES可以进入编辑状态，返回NO无法进入编辑状态
}
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField==self.TestField) {
//        self.label.text=@"END";
//    }
//}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField==self.TestField) {
        if ([textField.text isEqualToString:@"SNAKE"]){
            self.label.text=@"END";
            return YES;
        }
    }
    return NO;//当返回YES的时候正常状态，返回NO是不会结束编辑状态，也就不会激活textFieldShouldReturn事件
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    //还未实现
    return YES;
}

@end
